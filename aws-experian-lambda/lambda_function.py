import boto3
import json
import requests
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    secret_arn = os.environ['SECRET_ARN']
    client = boto3.client('secretsmanager', endpoint_url="http://localhost:4566")
    secret = client.get_secret_value(SecretId=secret_arn)
    creds = json.loads(secret['SecretString'])
    
    username = creds['username']
    password = creds['password']
    url = creds['url']
    client_id = creds['client_id']
    client_secret = creds['client_secret']
    
    logger.info(f"Resetting password for {username}")
    
    # Chamando Experian (mock para POC local)
    response = requests.post(url, json={
        "username": username,
        "password": password,
        "client_id": client_id,
        "client_secret": client_secret
    })
    
    logger.info(f"Experian response: {response.text}")
    
    return {"statusCode": response.status_code, "body": response.text}
