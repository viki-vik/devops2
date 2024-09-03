resource "aws_route53_record" "www" {
  zone_id = "ZONEIDXXX"
  name    = "test.vic.xyz"
  type    = "A"

  alias {
    name                   = aws_lb.flask_app.dns_name
    zone_id                = aws_lb.flask_app.zone_id
    evaluate_target_health = true
  }
}