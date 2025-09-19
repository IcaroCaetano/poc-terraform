# Terraform POC – EC2 Instance with Security Groups

## 📌 Overview

This Proof of Concept (POC) demonstrates how to use Terraform to provision an AWS EC2 instance with an associated Security Group.
The Security Group allows SSH (port 22) and HTTP (port 80) access, making it possible to connect to the instance and host a basic web application.


## 📂 Project Structure

´´´

terraform-ec2-sg-poc/
│── main.tf        # Defines provider, Security Group, and EC2 instance
│── variables.tf   # Input variables (instance type, key pair)
│── outputs.tf     # Outputs (public IP and DNS of the EC2 instance)

´´´

## ⚙️ Prerequisites

- Terraform installed (>= 1.3.0 recommended)

- AWS account with access keys configured (aws configure)

- A valid EC2 Key Pair already created in AWS for SSH access
