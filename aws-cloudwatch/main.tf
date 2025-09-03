terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  endpoints {
    cloudwatchlogs = "http://localhost:4566" # endpoint LocalStack
  }
}

resource "aws_cloudwatch_log_group" "poc_logs" {
  name              = "/poc/cloudwatch/logs"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "poc_stream" {
  name           = "poc-log-stream"
  log_group_name = aws_cloudwatch_log_group.poc_logs.name
}
