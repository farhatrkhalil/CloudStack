# Define Security Groups and their ingress/egress rules. ("Defense in Depth" strategy)

# ALB Security Group (Allows web traffic)
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# App Security Group (Only allows traffic FROM the ALB)
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id] # Chaining
  }
}

# Database Security Group (Only allows traffic FROM the App)
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port       = 1521 # Oracle Default Port
    to_port         = 1521
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id] # Chaining
  }
}
