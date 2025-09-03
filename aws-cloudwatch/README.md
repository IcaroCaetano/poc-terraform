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

```bash

localstack start -d
```

2. Verify services are running

```bash

localstack status services
```
3. Initialize Terraform

```bash

tflocal init
```

4. Preview the execution plan

```bash

tflocal plan
```

5. Apply the resources

```bash

tflocal apply -auto-approve
```
