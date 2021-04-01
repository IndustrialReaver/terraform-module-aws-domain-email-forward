resource "aws_s3_bucket" "email-store" {
  bucket = var.email_store_bucket_name
  acl    = "private"
  policy = templatefile("${path.module}/policies/bucket_policy.json", { account_id  = local.aws_account_id, bucket_name = var.email_store_bucket_name })

  tags = {
    Name = var.email_store_bucket_name
  }
}