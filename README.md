# poc-terraform

## 🌍 Terraform – Infrastructure as Code (IaC)

Terraform is an Infrastructure as Code (IaC) tool developed by HashiCorp that allows you to create, manage, and version infrastructure declaratively.
With Terraform, you describe what you want (resources, networks, permissions) in .tf configuration files, and Terraform takes care of creating, updating, or deleting these resources in the cloud securely and predictably.

## 💡 Key Concepts

### Providers

- Connect Terraform to the services you want to manage (AWS, Azure, GCP, Kubernetes, etc.).

- Example: "aws" provider connects Terraform to AWS or LocalStack for local testing.

### Resources

- Infrastructure elements you want to create, update, or delete.

- Example: S3 buckets, Secrets Manager, EC2 instances.

### State

- Terraform maintains a state file (terraform.tfstate) to know which resources already exist and how to manage them.

- Enables safe and predictable updates.

### Outputs

- Values ​​you want to expose after Terraform is applied.

- Example: ARN of a secret or name of an S3 bucket.

### Plan & Apply

- terraform plan → shows the changes that would be made (without applying).

- terraform apply → effectively applies the changes to the infrastructure.

## 🔗 Benefits of Terraform

Declarative: You describe the "desired state," not the individual steps.

Repeatable: Creates consistent environments across different regions or accounts.

Versionable: Configurations can be stored in Git.

Multi-cloud: Supports AWS, GCP, Azure, Kubernetes, and more.

Modular: Allows you to create reusable modules for different projects.
