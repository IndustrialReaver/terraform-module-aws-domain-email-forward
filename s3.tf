resource "aws_s3_bucket" "email-store" {
  bucket = var.email_store_bucket_name

  tags = {
    Name = var.email_store_bucket_name
  }
}

resource "aws_s3_bucket_acl" "email-bucket" {
  bucket = aws_s3_bucket.email-store.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "email-bucket" {
  bucket = aws_s3_bucket.email-store.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "email-bucket" {
  bucket = aws_s3_bucket.email-store.id
  policy = templatefile("${path.module}/policies/bucket_policy.json", { account_id = local.aws_account_id, bucket_name = var.email_store_bucket_name })
}