# Blog DEPLOYMENT

# Create kubernetes Name space for blog

resource "kubernetes_namespace" "kube-namespace-blog" {
  metadata {
    name = "blog-namespace"
    labels = {
      app = "blog"
    }
  }
}

# Create kubernetes deployment for blog

resource "kubernetes_deployment" "kube-deployment-blog" {
  metadata {
    name      = "blog"
    namespace = kubernetes_namespace.kube-namespace-blog.id
    labels = {
      app = "blog"
    } 
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "blog"
      }
    }
    template {
      metadata {
        labels = {
          app = "blog"
        }
      }
      spec {
        container {
          image = var.docker-image
          name  = "blog"
          env {
            name  = "MYSQL_HOST"
            value = "mysql"
          }
          env {
            name  = "MYSQL_PORT"
            value = "3306"
          }
        }
      }
    }
  }
}

# Create kubernetes service for blog

resource "kubernetes_service" "kube-service-blog" {
  metadata {
    name      = "blog"
    namespace = kubernetes_namespace.kube-namespace-blog.id
  }
  spec {
    selector = {
      app = "blog"
    }
    port {
      name = "metrics"
      port        = 80
      target_port = 80
    }
    port {
      name = "mysql"
      port        = 3306
      target_port = 3306
    }
    type = "LoadBalancer"
  }
}

# MYSQL database for blog app

resource "kubernetes_deployment" "blog-db" {
  metadata {
    name = "mysql"
    namespace = kubernetes_namespace.kube-namespace-blog.id
    labels = {
      app = "mysql"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mysql"
      }
    }
    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }

      spec {
        container {
          name = "mysql"
          image = "mysql:latest"

          env {
            name = "MYSQL_ROOT_PASSWORD"
            value = var.mysql-password
          }

          port {
            name = "mysql"
            container_port = 3306
          }

          volume_mount {
            name = "mysql-persistent-storage"
            mount_path = "/var/lib/mysql"
          }
        }

        volume {
          name = "mysql-persistent-storage"
          empty_dir {
            medium = "Memory"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "blog-db-service" {
  metadata {
    name = "mysql"
    namespace = kubernetes_namespace.kube-namespace-blog.id
  }

  spec {
    selector = {
      app = "mysql"
    }

    port {
      name = "mysql"
      port = 3306
      target_port = 3306
    }

    type = "ClusterIP"
  }
}

# SOCKS SHOP DEPLOYMENT

# Create kubernetes Name space for socks shop app

resource "kubernetes_namespace" "kube-namespace-socks" {
  metadata {
    name = "sock-shop"
  }
}

# Create kubectl deployment for socks app

data "kubectl_file_documents" "docs" {
    content = file("complete-demo.yaml")
}

resource "kubectl_manifest" "kube-deployment-socks" {
    for_each  = data.kubectl_file_documents.docs.manifests
    yaml_body = each.value
}

# Create separate kubernetes service for socks shop frontend

resource "kubernetes_service" "kube-service-socks" {
  metadata {
    name      = "front-end"
    namespace = kubernetes_namespace.kube-namespace-socks.id
    annotations = {
      "prometheus.io/scrape" = "true"
    }
    labels = {
      name = "front-end"
    }
  }
  spec {
    selector = {
      name = "front-end"
    }
    port {
      name = "metrics"
      port        = 80
      target_port = 8079
    }
    type = "LoadBalancer"
  }
}

# Print out loadbalancer DNS hostname for blog deployment

output "blog_load_balancer_hostname" {
  value = kubernetes_service.kube-service-blog.status.0.load_balancer.0.ingress.0.hostname
}

# Print out loadbalancer DNS hostname for socks deployment

output "socks_load_balancer_hostname" {
  value = kubernetes_service.kube-service-socks.status.0.load_balancer.0.ingress.0.hostname
}