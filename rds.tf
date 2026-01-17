resource "aws_db_subnet_group" "oracle_subnets" {
  name       = "oracle-subnet-group"
  subnet_ids = [aws_subnet.data_1.id, aws_subnet.data_2.id]
}

resource "aws_db_instance" "oracle_db" {
  identifier             = "cloudstack-oracle"
  engine                 = "oracle-ee"
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  db_subnet_group_name   = aws_db_subnet_group.oracle_subnets.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = var.skip_db_snapshot

  tags = {
    Name = "CloudStack-Oracle-DB"
    Role = "Database-Server"
  }
}
