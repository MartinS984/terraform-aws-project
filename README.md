# AWS Infrastructure Automation with Terraform

## Project Overview
This project automates the deployment of a scalable web server environment on AWS using Terraform. It provisions a Virtual Private Cloud (VPC), public subnets, internet gateways, and security groups to host an Nginx web server on an EC2 instance.

## Architecture
* **Cloud Provider:** AWS (us-east-1)
* **Infrastructure as Code:** Terraform
* **Compute:** EC2 (t2.micro)
* **OS:** Ubuntu 24.04 LTS

## Prerequisites
* Terraform installed
* AWS CLI configured with valid credentials

## How to Deploy
1.  Initialize Terraform: `terraform init`
2.  Review the plan: `terraform plan`
3.  Apply infrastructure: `terraform apply`