# 🚀 Terraform POC – AWS S3 & DynamoDB with LocalStack

This Proof of Concept (POC) demonstrates how to provision AWS resources (S3 and DynamoDB) using Terraform while running everything locally with LocalStack

It provides a simple way to test AWS infrastructure as code (IaC) without deploying to the real AWS cloud.

## 📌 Features

- S3 Bucket creation for storing objects.

- DynamoDB Table creation for basic key-value storage.

- LocalStack integration to emulate AWS locally.

- Terraform modules separated by files (s3.tf, dynamodb.tf, etc).

## 🛠 Prerequisites

- Terraform
 >= 1.5.0

- LocalStack
 (via Docker)

- AWS CLI
 (optional for testing)

## ⚙️ Setup Instructions
- 1. Start LocalStack
 
```

docker run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack
```

2. Initialize Terraform
