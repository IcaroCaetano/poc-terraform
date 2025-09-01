# AWS Experian Lambda POC

## 📌 Overview

This Proof of Concept (POC) demonstrates the setup and configuration of an AWS Lambda project integrated with Experian services.
The goal of this POC was to prepare the project structure, configure Git versioning rules, and exclude unnecessary files from version control, ensuring a clean and optimized repository.


### 🔹 Business Context:

- Experian requires passwords to be changed regularly and securely. To ensure the continuity of the integration in production, it was necessary to prepare and automate the password reset process, maintaining logs and security.

### 🔹 What was done at the business level:

- Automatic Experian password reset was prepared in production, ensuring that there are no authentication failures when the password expires.

- Sensitive credentials (users, passwords, client secret, client ID, and production URL) were stored securely in AWS Secrets Manager, following security practices.

- An automated process via Lambda was configured to perform password resets directly with Experian, without the need for manual intervention.

- All Lambda and Secrets Manager activity was configured to be monitored via Splunk, enabling traceability and auditing.

- Integration users were assigned fixed IP addresses, ensuring that Experian accepts calls (IP whitelisting).

### 🔹 Business benefit:

- Reduced risk of Experian integration failures due to expired passwords.

- Increased security and compliance, with properly stored credentials and centralized logs.

- Ensuring continuous production operation without impacting customers/end users.

## 🚀 Project Setup

```bash

git clone <repository-url>
cd aws-experian-lambda
```

## Project Structure

```perl

aws-experian-lambda/
│
├── package/               # Dependencies and external libraries
│   ├── __init__.py        # (ignored by Git)
│   └── ...                # (all contents ignored by Git)
│
├── src/                   # Source code for Lambda functions
│
├── tests/                 # Unit and integration tests
│
├── .gitignore             # Git ignore rules
└── README.md              # Project documentation
```

## 🛠 Deployment

The Lambda was designed to be deployed via AWS CLI or Terraform.
Example AWS CLI deployment:

```bash

aws lambda create-function \
  --function-name aws-experian-lambda \
  --runtime python3.9 \
  --role <iam-role-arn> \
  --handler handler.lambda_handler \
  --zip-file fileb://deployment-package.zip
```
