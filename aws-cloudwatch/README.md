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

## 📂 Resources Created

1- CloudWatch Log Group

- Name: /poc/cloudwatch/logs

- Retention: 7 days

2- CloudWatch Log Stream

- Name: poc-log-stream

- Associated with the Log Group above

## 🔍 How to Validate

List created log groups:

```bash

awslocal logs describe-log-groups
```

List streams inside the group:

```bash

awslocal logs describe-log-streams --log-group-name "/poc/cloudwatch/logs"
```


## 📝 Sending Log Events (test)


```bash

awslocal logs put-log-events \
  --log-group-name "/poc/cloudwatch/logs" \
  --log-stream-name "poc-log-stream" \
  --log-events '[{"timestamp": 1693560000000, "message": "Hello CloudWatch from Terraform POC"}]'
```


## 📦 Project Structure

```
terraform-cloudwatch-poc/
│── main.tf        # CloudWatch resource definitions
│── README.md      # POC documentation

```
