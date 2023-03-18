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
<p>In the terraform folder, we have another folder called backend, this folder contains the configuration of where the terraform state file will be stored. I used an S3 bucket and an AWS DynamoDB to ensure state locking and consistent state.</p>

The bucket and DynamoDB set up by the CircleCI Pipeline

[s3_bucket]()

[dynamodb]()

<h3>Setting up the Kubernetes and IAM</h3>
In the same terraform folder, there is a folder called infrastructure, the files in the folder has the configuration to provision an EKS cluster, create the VPC, set up an IAM role to secure access to who interacts with the cluster and other networking dependencies like lb and security group
