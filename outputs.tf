output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main_alb.dns_name
}

output "app_server_private_ip" {
  description = "Private IP address of the application server"
  value       = aws_instance.app_server.private_ip
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = aws_instance.bastion_host.public_ip
}

output "load_generator_public_ip" {
  description = "Public IP address of the load generator"
  value       = aws_instance.load_generator.public_ip
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.data_bucket.bucket
}

output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.oracle_db.endpoint
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "route53_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = aws_route53_zone.main.zone_id
}

output "route53_name_servers" {
  description = "Route 53 name servers for domain delegation"
  value       = aws_route53_zone.main.name_servers
}

output "app_dns_url" {
  description = "Application URL via Route 53"
  value       = "app.${var.domain_name}"
}

output "nat_gateway_ip" {
  description = "NAT Gateway public IP"
  value       = aws_eip.nat_eip.public_ip
}
