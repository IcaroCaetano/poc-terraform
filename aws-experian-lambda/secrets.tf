provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"

  endpoints {
    s3              = "http://localhost:4566"
    secretsmanager  = "http://localhost:4566"
    lambda          = "http://localhost:4566"
    iam             = "http://localhost:4566"
    cloudwatch      = "http://localhost:4566"
  }
}

resource "aws_secretsmanager_secret" "experian_secret" {
  name = "experian_credentials"
}

resource "aws_secretsmanager_secret_version" "experian_secret_version" {
  secret_id     = aws_secretsmanager_secret.experian_secret.id
  secret_string = jsonencode({
    username      = "user1"
    password      = "pass1"
    url           = "https://prod.experian.url"
    client_id     = "client-id"
    client_secret = "client-secret"
  })
}
