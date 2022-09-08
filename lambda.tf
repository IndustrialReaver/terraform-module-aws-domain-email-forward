locals {
  lambda_func_name = "${replace(var.domain, ".", "-")}-email-forwarder"
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_dir  = "${path.module}/src/aws-lambda-ses-forwarder-master/"
  output_path = "${path.module}/src/aws-lambda-ses-forwarder-master.zip"
}

resource "aws_lambda_permission" "ses_invoke" {
  statement_id   = "AllowExecutionFromSES"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.email_forwarder.function_name
  principal      = "ses.amazonaws.com"
  source_account = data.aws_caller_identity.current.id
}

resource "aws_lambda_function" "email_forwarder" {
  filename         = "${path.module}/src/aws-lambda-ses-forwarder-master.zip"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  function_name    = local.lambda_func_name
  handler          = "index.handler"
  publish          = true
  role             = aws_iam_role.lambda_email_forward_role.arn
  runtime          = "nodejs12.x"
  timeout          = 30
  memory_size      = 512

  environment {
    variables = {
      MailS3Bucket  = var.email_store_bucket_name
      MailS3Prefix  = var.email_store_prefix
      MailSender    = var.default_sender
      MailRecipient = var.default_recipient
      Region        = local.aws_region
      Domain        = var.domain
    }
  }

  tags = {
    Name = local.lambda_func_name
  }
}