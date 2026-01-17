variable "aws_region" {
  description = "AWS region for deployment"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource tagging"
  default     = "CloudStack"
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

variable "skip_db_snapshot" {
  description = "Skip final snapshot when destroying RDS (useful for testing)"
  type        = bool
  default     = true
}

variable "ami_owners" {
  description = "AMI owners for data source lookup"
  type        = list(string)
  default     = ["amazon"]
}

variable "ami_name_filter" {
  description = "AMI name filter pattern"
  type        = string
  default     = "amzn2-ami-hvm-*-x86_64-gp2"
}

variable "region_ami_mapping" {
  description = "Region-specific AMI name filters"
  type        = map(string)
  default = {
    "us-east-1"      = "amzn2-ami-hvm-*-x86_64-gp2"
    "us-west-2"      = "amzn2-ami-hvm-*-x86_64-gp2"
    "eu-west-1"      = "amzn2-ami-hvm-*-x86_64-gp2"
    "ap-southeast-1" = "amzn2-ami-hvm-*-x86_64-gp2"
  }
}
