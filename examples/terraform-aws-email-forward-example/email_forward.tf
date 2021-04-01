module "emaple_com_email_forwarding" {
    source = "git@github.com:IndustrialReaver/terraform-module-aws-domain-email-forward?ref=v1.0.0"

    email_store_bucket_name = var.email_store_bucket_name
    email_store_prefix      = var.email_store_prefix
    default_sender          = var.default_sender
    default_recipient       = var.default_recipient
    domain                  = var.domain
}