# This block defines settings and configurations that apply to Terraform itself.
# It usually specifies provider requirements, backend configurations, and version constraints.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Connects Terraform to LocalStack instead of real AWS.
# Defines the configuration for the AWS provider.
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  endpoints {
    cloudwatchlogs = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    iam            = "http://localhost:4566"
  }
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "poc_logs" {
  name              = "/poc/cloudwatch/logs"
  retention_in_days = 7
}

# CloudWatch Log Stream
resource "aws_cloudwatch_log_stream" "poc_stream" {
  name           = "poc-log-stream"
  log_group_name = aws_cloudwatch_log_group.poc_logs.name
}

# IAM Role para Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = { Service = "lambda.amazonaws.com" }
      }
    ]
  })
}

# Policy para CloudWatch Logs
resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Function simples (inline code)
resource "aws_lambda_function" "poc_lambda" {
  function_name = "poc_lambda"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  # Código inline (não precisa de arquivo zip externo)
  filename         = "${path.module}/lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda.zip")
}
