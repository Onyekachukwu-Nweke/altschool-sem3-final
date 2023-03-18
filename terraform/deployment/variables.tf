variable "cluster" {
  default = "eks-cluster"
}

variable "app" {
  type        = string
  description = "Name of application"
  default     = "blog"
}

variable "region" {
  default = "us-east-1"
}

variable "domain_name" {
  default = "onyekachukwuejiofornweke.me"
}

variable "docker-image" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "onyekachukwu/blog:1.0"
}

variable "mysql-password" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "my_db_password"
}