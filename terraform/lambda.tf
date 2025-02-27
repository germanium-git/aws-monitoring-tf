# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "budget_slack_lambda_role"

  assume_role_policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# IAM Policy for Logging
resource "aws_iam_policy" "lambda_logging" {
  name        = "LambdaLogging"
  description = "IAM policy for logging from a Lambda function"

  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach Policy to Lambda Role
resource "aws_iam_role_policy_attachment" "lambda_logging_attach" {
  policy_arn = aws_iam_policy.lambda_logging.arn
  role       = aws_iam_role.lambda_role.name
}

# Lambda Function for Sending Slack Messages
resource "aws_lambda_function" "budget_slack_lambda" {
  function_name = "BudgetSlackNotifier"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  filename         = "../python/lambda_function.zip" # Zip file containing the Python script
  source_code_hash = filebase64sha256("../python/lambda_function.zip")

  environment {
    variables = {
      SLACK_WEBHOOK_URL = var.slack_webhook_url
    }
  }
}
