#Create a zone in route53
resource "aws_route53_zone" "app_zone" {
  name = "${var.environment}.${var.domain_name}"
}

#Create a record on the given zone.
resource "aws_route53_record" "app_record" {
  zone_id = aws_route53_zone.app_zone.zone_id
  name    = "${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [var.instance_public_ip]
}