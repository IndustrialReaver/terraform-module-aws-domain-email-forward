# terraform-module-aws-domain-email-forward
Forward all emails sent to an AWS managed domain


Forwarder lambda code modified from https://github.com/arithmetric/aws-lambda-ses-forwarder

## Prereqs

To send emails from SES when it is in sandbox mode (the default) you must first validate both the sender and the recipient. This is not done by this terrafomr code and is a manual step. This can be completed after you run the terraform apply, but must be done before emails will be sent successfully. (Both of the addresses you supply in the default_recipient and default_sender input variable must be varified))

The domain must be registered in AWS, or at least the root DNS record (domain.com.) must be hosted in Route53 in the account this code is run in.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="email_store_bucket_name"></a> [email_store_bucket_name](#email_store_bucket_name) | The name of the s3 bucket to create to store inbound emails in. | `string` | `n/a` | yes |
| <a name="email_store_prefix"></a> [email_store_prefix](#email_store_prefix) | The key prefix that emails will be stored under in s3 (Should include trailing slash). | `string` | `incoming/` | yes |
| <a name="default_sender"></a> [default_sender](#default_sender) | The email address that the forwarded emails will be sent from (the reply to header will be overwritten to be the original sender). | `string` | `n/a` | yes |
| <a name="default_recipient"></a> [default_recipient](#default_recipient) | The email address to forward all emails to. | `string` | `n/a` | yes |
| <a name="domain"></a> [domain](#domain) | The domain to set up forwarding for (In the form example.com). | `string` | `n/a` | yes |