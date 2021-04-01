variable "aws_profile" {
  default = "default"  
}
variable "aws_region" {
  default = "us-east-1"
}
variable "email_store_bucket_name" {
  default = "example.com-email-store"
}
variable "email_store_prefix" {
  default = "incoming/"
}
variable "default_sender" {
  default = "email@example.com"
}
variable "default_recipient" {
  default = "exampleadmin@gmail.com"
}
variable "domain" {
  default = "example.com"  
}