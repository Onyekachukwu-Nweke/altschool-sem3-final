# AltSchool-of-Cloud-Engineering-3rd-Semester-Exam-Submission


<i>This project deploys two applications to the same kubernetes cluster using IaC and CI/CD approach.</i>

The following tools where used for this project which are:

- Kubernetes : an open-source container orchestration system for automating software deployment, scaling, and management.

- Kubectl: a tool used to interact with kubernetes clusters

- CircleCI: Is a cloud based CI/CD pipeline tool

- Terraform: Is a cloud agnostic IaC tool used to provision of the app

- Prometheus: Is a tool used for monitoring and alerting incase things starts get weary

- Grafana: Is an open source analytics and interactive visualization web application used to visualize performance metrics

- AWS: Is the cloud provider used for this project

## Step1: Setting up the Infrastructure with Terraform

<h3>Terraform Backend Setup</h3>
<p>In the terraform folder, we have another folder called backend, this folder contains the configuration of where the terraform state file will be stored. I created an S3 bucket to store the file and an AWS DynamoDB to ensure state locking and consistency of the state file.</p>

The bucket and DynamoDB set up by the CircleCI Pipeline

[s3_bucket]()

[dynamodb]()

<h3>Setting up the Kubernetes, IAM, Metrics and Logging</h3>
<p>In the same terraform folder, there is a folder called infrastructure, the files in the folder has the configuration to provision an EKS cluster, create the VPC, set up an IAM role to secure access to who interacts with the cluster and other networking dependencies like lb and security group.</p>

[EKS_cluster]()

[IAM_role]()

[VPC]()

[Route Table](/img/)

[SG]()

[ASG]()

<b>Also I setted up AWS Cloudwatch for logging and Metrics of the EKS cluster</b>

[cloudwatch]()

<h3>Deployment of Application</h3>
<p>This folder contains the deployment files which I used to setup domain name for the web application and the microservice application and also the kubernetes manifest file (```complete-demo.yaml```) used to install the apllication on the cluster and exposing of ports used in the various applications.</p>

[r53]

<p>In the microservices application, I setted up a service called front-end and gave it a ```LoadBalancer```, also the web application I dockerized it and pushed it to dockerhub built from Nginx image and connected it to a ```mysql-db``` also exposing the service ```3306```</p>

<h3>Provisioning a Monitoring system with Prometheus and Grafana</h3>
<p>In the terraform, another folder called monitoring, has a series of yaml files (kubernetes manifest files) used to setup monitoring and alerting tools such as prometheus and grafana in the kubernetes </p>

<p>In the grafana-svc and prometheus-svc files I changed ```NodePort``` to ```LoadBalancer```</p>

[prometheus]()

[grafana]()


## Step2: Dockerization of Udagram
<p>In the udagram-app folder, there is a dockerfile used to dockerize the application and push to docker through the pipeline</p>

[dockerhub]()

## Step3: CI/CD Pipeline with CircleCI
