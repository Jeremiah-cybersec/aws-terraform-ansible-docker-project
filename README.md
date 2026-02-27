# AWS Terraform Ansible Docker Project
Author: Jeremiah Ewere Lawrence
Course: Network and Systems Administration

---

## Project Overview
This project displays/demonstrates Infrastructure as Code and Configuration Management using tools such as:

- AWS EC2 - For cloud infastructure hosting 
- Terraform - For Infastructure provisioning
- Ansible - For Server configuration automation
- Docker - For container Runtime 
- GitHub - For version control

The aim of this project is to automate server provisioning, configuration, and deployment of a containerized web application.

---

## Automation Flow

### Step 1 – Infrastructure Provisioning (Terraform)
An AWS EC2 instance was automatically created using Terraform.

Files used:
- main.tf - This is for creating the EC2 instance and security group.
- variables.tf - This is for inputting variables that is used by terraform(e.g., instance type, key name).
- providers.tf - This is the AWS provider configuration (region/provider settings).
- output.tf - Outputs useful value after apply(e.g., 'instance ip').
- 'terraform.tfstate'/'terraform.tfstate.backup' - terraform state files (auto generated; usually not commited

Command flow:
terraform init - This initializes terraform and downloads all the required providers/modules.
terraform plan - This displays a preview of the infastructure modifications that terraform will make
terraform apply - This creates or updates the AWS resources. 

Terraform then gives outputs of the public IP of the EC2 instance.

---

### Step 2 – Configuration Management (Ansible)

After the server was created by Terraform, Ansible configured it automatically.

Tasks automated:
- I Connected to EC2 using SSH key
- I Updated the system packages
- I Installed Docker
- I Started the Docker service
- I Enableed Docker to start on boot

Files used:
- inventory.ini - It contains the EC2 public IP and and SSH key for connection
- install-docker.yml - This is the ansible playbook that will install and start the docker

Command used:
ansible-playbook -i inventory.ini install-docker.yml

Verification:
docker --version
sudo systemctl status docker

Results:
The results confirmed that docker was sucessfully installed and running.

## Security Considerations
- SSH access restricted via AWS security groups
- The private key was stores securely with chmod 400
- Infastructure defined as a code for auditing
  
---

### Step 3 – Docker Container Deployment
## 1. Overview

This part of the project illustrates the automated deployment of a containerised web application using Docker on an AWS EC2 instance that was provisioned using Terraform and configured using Ansible.

Here, a simple and straightforward HTML web application was built and assembled/packaged into a Docker image using a custom Dockerfile based on the lightweight Nginx Alpine image. The container was then deployed on the EC2 server and was made accessible and available through the public IP address.

This clearly depicts the use of Infrastructure as Code (IaC), DevOps automation, and cloud-based container deployment.

---

## 2. Project Structure

```
aws-terraform-ansible-docker-project/
├── terraform/
│ └── (Terraform files to provision the EC2 instance + security group)
├── ansible/
│ ├── deploy-webapp.yml
│ ├── install-docker.yml
│ └── inventory.ini
└── app/
├── Dockerfile
└── index.html
```

---

## 3. Dockerfile Explanation

The Dockerfile executes the following steps:

1. It uses `nginx:alpine` as a lightweight base image
2. Then Copies the HTML file into the Nginx web directory
3. Then it Exposes port **80** for HTTP access

Example Dockerfile:

```
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
```

---

## 4. Build and Run the Container(Manual method)
### SSH into EC2
```
ssh -i ~/terraform-key-new.pem ubuntu@54.171.166.157
```

### Copy app to server 
```
scp -i ~/terraform-key-new.pem -r ./app ubuntu@54.171.166.157:~/
```

### Build Docker Image
```
docker build -t jeremiah-webapp .
```

### Run Docker Container(HTTP on port 80)
```
docker run -d -p 80:80 --name webapp-test jeremiah-webapp
```

### Verify container is running
```
docker ps
curl -I http://localhost
```

---

## 5. Automated Deployment with Ansible

The deployment process was automated using ansible playbook

Run the playbook:

```
ansible-playbook -i inventory.ini deploy-webapp.yml
```

This playbook:
- Pulls the Docker image
- Starts the container
- Guarantees/ensures the container is running

### Copy app to server 
```
Open in your browser:
http://54.171.166.157
```

---

## 6. Security Considerations

- EC2 Security Group permits only required ports (22, 80)
- Docker image uses minimal/simple `nginx:alpine` to reduce attack surface
- Automation decreases/minimizes configuration errors

---

## 7. Outcome

- My Docker container was successfully deployed
- My Web application is accessible via EC2 public IP
- Integrated Terraform + Ansible + Docker workflow completed

This confirms successful automation of infrastructure provisioning, configuration management, and container deployment.

---


---

