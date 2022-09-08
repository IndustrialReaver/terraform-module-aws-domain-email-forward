resource "aws_iam_role" "lambda_email_forward_role" {
  name = "${replace(var.domain, ".", "-")}-LambdaEmailForwardRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "s3_ses_access" {
  name        = "${replace(var.domain, ".", "_")}_s3_ses_access"
  path        = "/"
  description = "Allow Lambda to send emails stored in s3"

  policy = templatefile("${path.module}/policies/iam_policy.json", { region = local.aws_region, account_id = local.aws_account_id, bucket_name = var.email_store_bucket_name })
}

resource "aws_iam_policy_attachment" "s3_ses_access-attach" {
  name       = "${replace(var.domain, ".", "_")}_s3_ses_access-attachment"
  roles      = [aws_iam_role.lambda_email_forward_role.name]
  policy_arn = aws_iam_policy.s3_ses_access.arn
}