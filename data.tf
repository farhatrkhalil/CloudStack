data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [lookup(var.region_ami_mapping, var.aws_region, var.ami_name_filter)]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
