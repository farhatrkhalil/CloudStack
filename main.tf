# Define the EC2 instances, Application Load Balancer, and Target Groups. ("Compute" layer)

# --- Application Load Balancer ---
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

# --- Compute Instances (App & Server) ---
resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_app_1.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = { Name = "CloudStack-App-Instance" }
}

# --- S3 Integration ---
resource "aws_s3_bucket" "data_bucket" {
  bucket = "cloudstack-data-storage-unique-id" 
  tags   = { Name = "CloudStack-S3" }
}
