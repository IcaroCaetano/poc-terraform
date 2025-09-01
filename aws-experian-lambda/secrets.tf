# Define the AWS provider:
provider "aws" {
  region     = "us-east-1" # region → sets the AWS region (here us-east-1)
  access_key = "test" # access_key and secret_key → dummy values because LocalStack doesn’t validate real AWS credentials
  secret_key = "test"

# Override AWS service endpoints so Terraform points to LocalStack instead of real AWS:
  endpoints {
    s3              = "http://localhost:4566" # s3 → local S3
    secretsmanager  = "http://localhost:4566" # secretsmanager → local Secrets Manager
    lambda          = "http://localhost:4566" # lambda → local Lambda
    iam             = "http://localhost:4566" # iam → local IAM
    cloudwatch      = "http://localhost:4566" # cloudwatch → local CloudWatch
  }
}

# Create a Secrets Manager secret named experian_credentials.
# This defines the “container” for storing secret values (like Experian credentials).
resource "aws_secretsmanager_secret" "experian_secret" {
  name = "experian_credentials"
}

# Attach a version/value to the secret:
resource "aws_secretsmanager_secret_version" "experian_secret_version" {
  secret_id     = aws_secretsmanager_secret.experian_secret.id # links this secret value to the experian_secret resource
  secret_string = jsonencode({ # stores the actual secret data in JSON format:
    username      = "user1" # username, password → login credentials
    password      = "pass1"
    url           = "https://prod.experian.url" # url → Experian API URL
    client_id     = "client-id" # client_id, client_secret → OAuth credentials
    client_secret = "client-secret"
  })
}
