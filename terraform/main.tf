# Create an SNS Topic for Budget Alerts
resource "aws_sns_topic" "budget_alerts" {
  name = "BudgetAlerts"
}

# AWS Budget Resource
resource "aws_budgets_budget" "monthly_budget" {
  name         = "Monthly-Budget-10USD-50"
  budget_type  = "COST"
  limit_amount = "10" # Budget limit in USD
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 50
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_sns_topic_arns = [aws_sns_topic.budget_alerts.arn]
  }
}

# # Grant SNS Permission to Invoke Lambda
# resource "aws_sns_topic_subscription" "lambda_sub" {
#   topic_arn = aws_sns_topic.budget_alerts.arn
#   protocol  = "lambda"
#   endpoint  = aws_lambda_function.budget_slack_lambda.arn
# }

# # Allow SNS to invoke Lambda
# resource "aws_lambda_permission" "allow_sns" {
#   statement_id  = "AllowExecutionFromSNS"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.budget_slack_lambda.function_name
#   principal     = "sns.amazonaws.com"
#   source_arn    = aws_sns_topic.budget_alerts.arn
# }
