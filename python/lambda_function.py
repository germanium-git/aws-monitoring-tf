import json
import os
import urllib3

def lambda_handler(event, context):
    webhook_url = os.environ['SLACK_WEBHOOK_URL']
    http = urllib3.PoolManager()

    message = {
        "text": f"🚨 AWS Budget Alert! 🚨\nYour AWS spending has exceeded the defined threshold. \nDetails: {json.dumps(event, indent=2)}"
    }

    encoded_msg = json.dumps(message).encode('utf-8')
    response = http.request('POST', webhook_url, body=encoded_msg, headers={'Content-Type': 'application/json'})

    return {
        'statusCode': response.status,
        'body': response.data.decode('utf-8')
    }
