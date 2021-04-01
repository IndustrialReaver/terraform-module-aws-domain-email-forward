variable "email_store_bucket_name" {
  type = string
  description = "The name of the s3 bucket to create to store inbound emails in."
}
variable "email_store_prefix" {
  type = string
  description = "The key prefix that emails will be stored under in s3 (Should include trailing slash)."
  default = "incoming/"
}
variable "default_sender" {
  type = string
  description = "The email address that the forwarded emails will be sent from (the reply to header will be overwritten to be the original sender)."
}
variable "default_recipient" {
  type = string
  description = "The email address to forward all emails to."
}
variable "domain" {
  type = string
  description = "The domain to set up forwarding for (In the form example.com)."
}