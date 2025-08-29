# POC: Terraform + LocalStack – S3 & Secrets Manager

This is a small proof of concept (POC) to demonstrate how to use Terraform with LocalStack to create AWS resources locally.
It covers creating a Secrets Manager secret and an S3 bucket, simulating a cloud environment entirely on your local machine.

## 📂 Project Structure
```
localstack-poc/
 ├── main.tf        # Terraform resources: S3 bucket & Secrets Manager
 ├── variables.tf   # Input variables for AWS credentials and region
 └── outputs.tf     # Outputs: bucket name and secret ARN
```

## 📊 Diagrama de Recursos – POC LocalStack

```
+----------------------+               +--------------------------+
|      Terraform       |               |       LocalStack         |
|  (your configuration)|               |  (simulated AWS cloud)  |
+----------------------+               +--------------------------+
           |                                     |
           | terraform apply / tflocal apply    |
           v                                     v
+----------------------+               +--------------------------+
|  Provider AWS         | ------------> |  Endpoints LocalStack    |
| (configured for LS)  |               |  S3 -> http://localhost:4566
|                      |               |  SecretsManager -> http://localhost:4566
+----------------------+               +--------------------------+
           |                                     |
           |                                     |
           v                                     v
+----------------------+               +--------------------------+
|   Resources:         |               |  LocalStack Services     |
| - S3 Bucket          | ------------> |  S3 Bucket:              |
|   poc-localstack-bucket |            |  poc-localstack-bucket   |
| - SecretsManager      | ------------> |  Secret: poc-secret      |
|   poc_secret          |               |  SecretValue:            |
| - Secret Version      |               |  { username, password }  |
+----------------------+               +--------------------------+
```

### 1️⃣ main.tf

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region                      = var.aws_region
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  s3_force_path_style         = true
  endpoints {
    s3             = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "poc_bucket" {
  bucket = "poc-localstack-bucket"
}

# Secrets Manager secret
resource "aws_secretsmanager_secret" "poc_secret" {
  name        = "poc-secret"
  description = "POC secret for LocalStack Terraform"
}

# Secret value
resource "aws_secretsmanager_secret_version" "poc_secret_version" {
  secret_id     = aws_secretsmanager_secret.poc_secret.id
  secret_string = jsonencode({
    username = "localstack-user"
    password = "localstack-pass"
  })
}

```

Explanation:

- terraform { required_providers } → declares the AWS provider for Terraform.

- provider "aws" → points to LocalStack endpoints instead of real AWS.

- aws_s3_bucket → creates a bucket named poc-localstack-bucket.

- aws_secretsmanager_secret → creates a secret named poc-secret.

- aws_secretsmanager_secret_version → stores a JSON object with username and password.

### 2️⃣ variables.tf

```
variable "aws_region" {
  default = "us-east-1"
}

variable "aws_access_key" {
  default = "test"
}

variable "aws_secret_key" {
  default = "test"
}

```

Explanation:

- Defines input variables for AWS configuration.

- LocalStack does not validate credentials, so test is used as a placeholder.

### 3️⃣ outputs.tf

```
output "bucket_name" {
  value = aws_s3_bucket.poc_bucket.id
}

output "secret_arn" {
  value = aws_secretsmanager_secret.poc_secret.arn
}

```

Explanation:

- bucket_name → outputs the S3 bucket ID.

- secret_arn → outputs the Secrets Manager ARN.

## 🚀 Step-by-Step Instructions

### 1. Start LocalStack

```bash

localstack start
```

or with Docker:

```bach

docker run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack
```

### 2. Initialize Terraform

```bash

tflocal init
```

- Downloads provider plugins.

- Creates a temporary localstack_providers_override.tf pointing to LocalStack endpoints.


### 3. Validate Terraform

````bash

tflocal validate
````

- Checks .tf files for syntax errors or missing references.

### 4. Create Terraform Plan

```bash

tflocal plan
```

- Shows resources to be created.

- Example output:


```terminaloutput
Plan: 3 to add, 0 to change, 0 to destroy.
Changes to Outputs:
  + bucket_name = (known after apply)
  + secret_arn  = (known after apply)
```

### 5. Apply Terraform Plan

```bash

tflocal apply
```

- Type yes to confirm.

- Resources are created in LocalStack, not AWS.

### 6. Inspect Resources

6.1 Terraform state

```bash

tflocal state list
tflocal output
```

- Lists all resources managed by Terraform.

- Shows output values like bucket name and secret ARN.

6.2 LocalStack CLI (awslocal)

- List S3 buckets:

```bash

awslocal s3 ls
```

- List Secrets Manager secrets:

```bash

awslocal secretsmanager list-secrets
```

- Get secret value:

```bash

awslocal secretsmanager get-secret-value --secret-id poc-secret
```

## ⚡ Notes

LocalStack simulates AWS locally, so nothing appears in the real AWS console.

tflocal is a wrapper for Terraform that automatically points providers to LocalStack.

Always export dummy credentials:

```bash

export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
```

- For modules with their own provider "aws", use:

```

ADDITIONAL_TF_OVERRIDE_LOCATIONS=./modules/your-module tflocal plan
```
