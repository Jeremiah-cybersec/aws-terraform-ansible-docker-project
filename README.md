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
(To be completed next)

---

