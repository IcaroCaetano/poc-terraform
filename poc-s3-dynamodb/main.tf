terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}

# Aqui você só importa os outros arquivos que já criamos
# O Terraform automaticamente carrega *.tf, mas deixamos explícito
# para organizar a POC.

module "s3" {
  source = "./"
}

module "dynamodb" {
  source = "./"
}

