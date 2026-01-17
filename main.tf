resource "aws_lb" "main_alb" {
  name               = "cloudstack-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_app_1.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_app_profile.name

  tags = {
    Name = "CloudStack-App-Instance"
    Role = "Application-Server"
  }
}

resource "aws_instance" "bastion_host" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.alb_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name

  tags = {
    Name = "CloudStack-Bastion-Host"
    Role = "Management-Host"
  }
}

resource "aws_s3_bucket" "data_bucket" {
  bucket = "${var.project_name}-data-storage-${random_id.bucket_suffix.hex}"
  tags   = { Name = "${var.project_name}-S3" }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
