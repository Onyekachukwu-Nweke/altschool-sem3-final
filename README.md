# AltSchool-of-Cloud-Engineering-3rd-Semester-Exam-Submission

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/Onyekachukwu-Nweke/altschool-sem3-final/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/Onyekachukwu-Nweke/altschool-sem3-final/tree/main)

<i>This project deploys two applications to the same kubernetes cluster using IaC and CI/CD approach.</i>

The following tools where used for this project which are:

- <code>Kubernetes</code> : an open-source container orchestration system for automating software deployment, scaling, and management.

- <code>Kubectl</code>: a tool used to interact with kubernetes clusters

- <code>CircleCI</code>: Is a cloud based CI/CD pipeline tool

- <code>Terraform</code>: Is a cloud agnostic IaC tool used to provision of the app

- <code>Prometheus</code>: Is a tool used for monitoring and alerting incase things starts get weary

- <code>Grafana</code>: Is an open source analytics and interactive visualization web application used to visualize performance metrics

- <code>AWS</code>: Is the cloud provider used for this project

- <code>Docker</code> and <code>Dockerhub</code>

- <code>Git</code> and <code>Github</code>

## Step1: Setting up the Infrastructure with Terraform

<h3>Terraform Backend Setup</h3>
<p>In the terraform folder, we have another folder called backend, this folder contains the configuration of where the terraform state file will be stored. I created an S3 bucket to store the file and an AWS DynamoDB to ensure state locking and consistency of the state file.</p>

The bucket and DynamoDB set up by the CircleCI Pipeline

[s3_bucket]()

[dynamodb]()

<h3>Setting up the Kubernetes, IAM, Metrics and Logging</h3>
<p>In the same terraform folder, there is a folder called infrastructure, the files in the folder has the configuration to provision an EKS cluster, create the VPC, set up an IAM role to secure access to who interacts with the cluster and other networking dependencies like lb and security group.</p>

[EKS_cluster](/img/eks.png)

[IAM_role]()

[VPC]()

[Route Table](/img/)

[SG]()

[ASG]()

<b>Also I setted up AWS Cloudwatch for logging and Metrics of the EKS cluster</b>

[cloudwatch]()

<h3>Deployment of Application</h3>
<p>This folder contains the deployment files which I used to setup domain name for the web application and the microservice application and also the kubernetes manifest file (```complete-demo.yaml```) used to install the apllication on the cluster and exposing of ports used in the various applications.</p>

![r53](/img/r53.png)

<p>In the microservices application, I setted up a service called front-end and gave it a ```LoadBalancer```, also the web application I dockerized it and pushed it to dockerhub built from Nginx image and connected it to a ```mysql-db``` also exposing the service ```3306```</p>


## Step2: Dockerization of Udagram
<p>In the udagram-app folder, there is a dockerfile used to dockerize the application and push to docker through the pipeline</p>

[dockerhub]()

## Step3: CI/CD Pipeline with CircleCI
CI/CD was implemented for this project using `CircleCI`. The code for the CI/CD pipeline can be found in the `.circleci` folder which contains a `config.yml` file containing the code for the CI/CD pipeline. The CI/CD pipeline has six jobs;

1. `build_docker_image`: this job builds the docker image for the portfolio app and pushes the built image to dockerhub image repository.

2. `create_backend_state_store`: this job applies the terraform script(s) in the `terraform-files/backend` directory. This will create and S3 backend and DynamoDB for storing and locking state. This job will only execute if the `backend` branch of the repository is triggered.

3. `create_infrastructure`: this job applies the terraform script(s) in the `terraform-files/infrastructure` directory. This will create the network infrastructure as earlier stated.

4. `deploy_applications`: this job applies the terraform script(s) in the `terraform-files/deployment` directory. This will deploy the two applications to the EKS cluster created in the previous job. It also creates two subdomains and maps the loadbalancers from the two applications to the subdomains.

5. `configure_monitoring`: this job applies the terraform script(s) in the `terraform-files/monitoring` directory. This will deploy prometheus and grafana to the cluster.

6. `destroy_everything`: this job will destroy the whole deployment and infrastructure by executing `terraform destroy --auto-approve` in the `terraform-files/monitoring`, `terraform-files/deployment` and `terraform-files/infrastructure` directories. This job will only execute if the `destroy` branch of the repository is triggered.

![CICD image](/img/CICD.png)

![cicd-deploy image](/img/deployCICD.png)

The images shows the successful execution of the jobs in the CI/CD pipeline after it was triggered.


## Step4: Provisioning a Monitoring system with Prometheus and Grafana
<p>In the terraform, another folder called monitoring, has a series of yaml files (kubernetes manifest files) used to setup monitoring and alerting tools such as prometheus and grafana in the kubernetes. Using the cloud watch logs to analyze system performance/ </p>

<p>In the grafana-svc and prometheus-svc files I changed <code>NodePort</code> to ``LoadBalancer``</p>

- Prometheus Access Point: <a target=_blank href="http://prometheus.onyekachukwuejiofornweke.me:9090/targets">Prometheus url</a>

![prometheus](/img/prometheus.png)

- Grafana Access Point: <a target=_blank href="">Grafana url</a>
[grafana]()