import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    logger.info("🚀 Lambda POC executed successfully!")
    logger.debug("🔍 Event received: %s", json.dumps(event))

    # Retorno simples
    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Hello from Lambda POC!"})
    }
