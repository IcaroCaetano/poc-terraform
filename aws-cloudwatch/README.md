# Terraform POC – CloudWatch Logs with LocalStack'

## 📌 Objective

This Proof of Concept (POC) aims to validate the creation of AWS CloudWatch Logs resources using Terraform in a local environment with LocalStack.
The following resources are provisioned:

- A Log Group

- A Log Stream inside the group

## 🛠️ Prerequisites

Before running this POC, make sure you have the following installed:

- Terraform

- LocalStack

- AWS CLI Local (awslocal)

- Docker running (required for LocalStack).

- On macOS, you can use Colima or Docker Desktop.

## 🚀 Steps to Run

1. Start LocalStack
