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

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.data_bucket.bucket
}

output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.oracle_db.endpoint
}
