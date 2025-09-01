resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"   # Sets the name of the IAM role to be used by the Lambda

  assume_role_policy = jsonencode({   # Policy that defines who can assume this role
    Version = "2012-10-17"           # Policy version (AWS standard)
    Statement = [{                    # List of permissions
      Action    = "sts:AssumeRole"   # Allows the entity to assume this role
      Effect    = "Allow"            # Effect: allow
      Principal = { Service = "lambda.amazonaws.com" }
        # Who can assume the role: the Lambda service
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec.name
    # Name of the role to attach the policy to
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    # AWS-managed policy allowing: CloudWatch logging and basic Lambda execution
}

resource "aws_lambda_function" "experian_reset" {
  function_name = "experian_password_reset"  # Name of the Lambda function
  runtime       = "python3.11"               # Runtime environment: Python 3.11
  handler       = "lambda_function.lambda_handler"
    # Entry point: file `lambda_function.py` and function `lambda_handler`
  role          = aws_iam_role.lambda_exec.arn
    # IAM role the Lambda assumes during execution

   filename         = "lambda_function.zip"
      # ZIP file containing the Python Lambda code
    source_code_hash = filebase64sha256("lambda_function.zip")
      # Base64 hash of the ZIP file used by Terraform to detect code changes
  
  environment {
    variables = {
      SECRET_ARN = aws_secretsmanager_secret.experian_secret.arn
        # Lambda environment variable: ARN of the Secret Manager containing Experian credentials
    }
  }
}
