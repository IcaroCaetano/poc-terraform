import json
import logging

# Configure the logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    # Log a message to CloudWatch
    logger.info("🚀 Lambda POC executed successfully!")
    logger.debug("🔍 Event received: %s", json.dumps(event))

    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Hello from Lambda POC!"})
    }
