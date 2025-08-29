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
    s3                 = "http://localhost:4566"
    secretsmanager     = "http://localhost:4566"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "poc_bucket" {
  bucket = "poc-localstack-bucket"
}

# Secret Manager
resource "aws_secretsmanager_secret" "poc_secret" {
  name        = "poc-secret"
  description = "POC secret for LocalStack Terraform"
}

resource "aws_secretsmanager_secret_version" "poc_secret_version" {
  secret_id     = aws_secretsmanager_secret.poc_secret.id
  secret_string = jsonencode({
    username = "localstack-user"
    password = "localstack-pass"
  })
}
