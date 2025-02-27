# AWS Monitoring with Terraform

Create a lambda function to get notified when the budget goes beyond the limit

## Getting started

### slack_webhook_url
Use the webhook from Bitwarden stored in the item Slack-webhook for alerts in AWS

### lambda_function.zip
Create a zipped file from the python code and store it in /python/lambda_function.zip before running Terraform. The zip file is not tracked by Git.