resource "aws_ses_domain_identity" "domain" {
  domain = var.domain
}

resource "aws_ses_receipt_rule_set" "primary" {
  rule_set_name = "${replace(var.domain, ".", "-")}-primary-rules"
}

resource "aws_ses_receipt_rule" "store" {
  depends_on = [
    aws_lambda_function.email_forwarder,
  ]
  name          = "${replace(var.domain, ".", "-")}-store"
  rule_set_name = aws_ses_receipt_rule_set.primary.id
  enabled       = true
  scan_enabled  = true

  s3_action {
    bucket_name       = var.email_store_bucket_name
    position          = 1
    object_key_prefix = var.email_store_prefix
  }

  lambda_action {
    function_arn    = aws_lambda_function.email_forwarder.arn
    invocation_type = "Event"
    position        = 2
  }
}

resource "aws_ses_active_receipt_rule_set" "main" {
  rule_set_name = aws_ses_receipt_rule_set.primary.id
}