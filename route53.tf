data "aws_route53_zone" "primary" {
  name         = "${var.domain}."
  private_zone = false
}

resource "aws_route53_record" "mx" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.domain
  type    = "MX"
  ttl     = "1800"
  records = [ "10 inbound-smtp.${local.aws_region}.amazonaws.com" ]
}

resource "aws_route53_record" "domain_amazonses_verification_record" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "1800"
  records = [aws_ses_domain_identity.domain.verification_token]
}