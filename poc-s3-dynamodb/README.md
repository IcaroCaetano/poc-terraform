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

```

terraform init
```

3. Validate the configuration

```

terraform validate
```

4. Apply the infrastructure

```

terraform apply -auto-approve
```

5. Destroy the infrastructure (cleanup)

```

terraform destroy -auto-approve
```

## 📂 Project Structure

```
.
├── main.tf          # Main entry point for Terraform
├── provider.tf      # AWS provider with LocalStack endpoints
├── s3.tf            # S3 bucket resource
├── dynamodb.tf      # DynamoDB table resource
├── outputs.tf       # Useful outputs after apply
└── README.md        # Documentation

```

## 🔍 Testing the Resources

List S3 Buckets

```
aws --endpoint-url=http://localhost:4566 s3 ls
```

Put an Object in S3

```
aws --endpoint-url=http://localhost:4566 s3 cp ./test.txt s3://poc-s3-bucket/
```

List DynamoDB Tables


```

aws --endpoint-url=http://localhost:4566 dynamodb list-tables
```

## ✅ Expected Outcome

- An S3 bucket named poc-s3-bucket.

- A DynamoDB table named poc-dynamodb-table.

- Both running locally on LocalStack without touching real AWS.

## 📖 Next Steps

-Extend this POC with Lambda + API Gateway.

- Add CloudWatch Logs for monitoring.

- Configure a remote backend (S3 + DynamoDB lock) for state management.
