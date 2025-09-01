import boto3 # AWS SDK for Python, used to access Secrets Manager
import json # to parse JSON strings
import requests # to make HTTP requests (to Experian API)
import logging # to create log messages

# Create a logger instance and set the logging level to INFO, so all info messages will be captured.
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# event → input data passed to the Lambda
# context → runtime information about the Lambda invocation
def lambda_handler(event, context):
    # Retrieve the Secrets Manager ARN from the Lambda environment variable SECRET_ARN.
    secret_arn = os.environ['SECRET_ARN']
    # Create a Secrets Manager client with boto3.
    # endpoint_url="http://localhost:4566" → points to LocalStack for local testing.
    client = boto3.client('secretsmanager', endpoint_url="http://localhost:4566")
    # Fetch the secret using the ARN.
    # Parse the JSON string into a Python dictionary creds.
    secret = client.get_secret_value(SecretId=secret_arn)
    creds = json.loads(secret['SecretString'])

    # Extract credentials and API info from the secret for the Experian request.
    username = creds['username']
    password = creds['password']
    url = creds['url']
    client_id = creds['client_id']
    client_secret = creds['client_secret']

    # Log the action: which username is having its password reset. Useful for monitoring and debugging.
    logger.info(f"Resetting password for {username}")
    
    # Calling Experian (mock for local POC)
    # Send a POST request to the Experian API (mocked for local POC).
    # The data is sent as JSON containing username, password, client ID, and client secret.
    response = requests.post(url, json={
        "username": username,
        "password": password,
        "client_id": client_id,
        "client_secret": client_secret
    })

    # Log the response from Experian. Useful for debugging or confirming the request outcome.
    logger.info(f"Experian response: {response.text}")

    # Return a Lambda-compatible response:
    # statusCode → HTTP status code from the Experian response
    # body → response content as text
    return {"statusCode": response.status_code, "body": response.text}
