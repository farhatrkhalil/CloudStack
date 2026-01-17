variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "CloudStack"
}

variable "domain_name" {
  description = "Domain name for Route 53 DNS zone"
  default     = "cloudstack.local"
}

variable "instance_type" {
  description = "EC2 instance type for application servers"
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "RDS instance class"
  default     = "db.t3.small"
}
