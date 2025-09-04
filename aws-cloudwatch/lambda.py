import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    logger.info("🚀 Lambda POC executada com sucesso!")
    logger.debug("🔍 Evento recebido: %s", json.dumps(event))

    # Retorno simples
    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Hello from Lambda POC!"})
    }
