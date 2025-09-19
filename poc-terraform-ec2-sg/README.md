# Terraform POC – EC2 Instance with Security Groups

## 📌 Overview

This Proof of Concept (POC) demonstrates how to use Terraform to provision an AWS EC2 instance with an associated Security Group.
The Security Group allows SSH (port 22) and HTTP (port 80) access, making it possible to connect to the instance and host a basic web application.


## 📂 Project Structure

```

terraform-ec2-sg-poc/
│── main.tf        # Defines provider, Security Group, and EC2 instance
│── variables.tf   # Input variables (instance type, key pair)
│── outputs.tf     # Outputs (public IP and DNS of the EC2 instance)

```

## ⚙️ Prerequisites

- Terraform installed (>= 1.3.0 recommended)

- AWS account with access keys configured (aws configure)

- A valid EC2 Key Pair already created in AWS for SSH access

##   🚀 How It Works

### 1- Provider Configuration

- Connects Terraform to AWS using the aws provider.

### 2 - Security Group

- Allows inbound traffic on port 22 (SSH) from anywhere.

- Allows inbound traffic on port 80 (HTTP) from anywhere.

- Allows all outbound traffic.

### 3 - EC2 Instance

- Creates an Ubuntu-based EC2 instance (t2.micro by default).

- Attaches the Security Group created earlier.

- Associates a key pair for SSH login.

### 4 - Outputs

- Displays the Public IP and Public DNS of the created instance.

## 🛠 Usage

### 1. Initialize Terraform

```

terraform init
```

### 2. Validate the configuration

```

terraform validate
```

### 3. Plan the infrastructure

```

terraform plan -var="key_pair_name=your-keypair-name"
```

### 4. Apply the configuration

```

terraform apply -var="key_pair_name=your-keypair-name" -auto-approve
```

### 5. Access the EC2 Instance

After deployment, Terraform will output the Public IP.
Connect via SSH:

```
ssh -i your-keypair.pem ubuntu@<EC2_PUBLIC_IP>
```

## 📤 Outputs

After applying, Terraform provides:

- ec2_public_ip → Public IP address of the EC2 instance

- ec2_public_dns → Public DNS address of the EC2 instance

Example:

```

Outputs:

ec2_public_ip  = "54.210.123.45"
ec2_public_dns = "ec2-54-210-123-45.compute-1.amazonaws.com"
```

### 📌 Notes

- For security reasons, it is recommended to restrict SSH access to your own IP instead of 0.0.0.0/0.

- You can deploy a simple web server (e.g., nginx or Apache) to test HTTP access.

- This POC uses a public Ubuntu AMI (ami-0c55b159cbfafe1f0), which may change over time. Update it if needed.


