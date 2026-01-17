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

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "app_attachment" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app_server.id
  port             = 80
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_app_1.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_app_profile.name
  user_data = base64encode(<<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>CloudStack App Server - Running</h1>" > /var/www/html/index.html
EOF
  )

  tags = {
    Name = "CloudStack-App-Instance"
    Role = "Application-Server"
  }
}

resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name

  tags = {
    Name = "CloudStack-Bastion-Host"
    Role = "Management-Host"
  }
}

resource "aws_instance" "load_generator" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_2.id
  vpc_security_group_ids = [aws_security_group.load_generator_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.load_generator_profile.name

  user_data = base64encode(<<-EOF
#!/bin/bash
yum update -y
yum install -y httpd-tools stress
echo "<h1>CloudStack Load Generator - Ready</h1>" > /var/www/html/index.html
EOF
  )

  tags = {
    Name = "CloudStack-Load-Generator"
    Role = "Load-Testing"
  }
}

resource "aws_s3_bucket" "data_bucket" {
  bucket = "${var.project_name}-data-storage-${random_id.bucket_suffix.hex}"
  tags   = { Name = "${var.project_name}-S3" }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
