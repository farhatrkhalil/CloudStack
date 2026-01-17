# Route 53 DNS Configuration
resource "aws_route53_zone" "main" {
  name = var.domain_name

  tags = {
    Name        = "${var.project_name}-DNS-Zone"
    Environment = "Production"
  }
}

# A record for the Application Load Balancer
resource "aws_route53_record" "alb" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "app.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.main_alb.dns_name
    zone_id                = aws_lb.main_alb.zone_id
    evaluate_target_health = true
  }
}

# CNAME record for direct API access
resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.main_alb.dns_name]
}

# NS records for domain delegation (output for manual configuration)
resource "aws_route53_record" "ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "NS"
  ttl     = 172800

  records = [
    for ns in aws_route53_zone.main.name_servers : ns
  ]
}
