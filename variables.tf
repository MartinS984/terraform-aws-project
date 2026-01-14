# variables.tf

variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The name prefix for all resources"
  type        = string
  default     = "devops-project"
}

variable "vpc_cidr" {
  description = "The IP range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "The EC2 instance type (Free tier eligible)"
  type        = string
  default     = "t2.micro"
}