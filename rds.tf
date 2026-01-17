# Provision the Oracle RDS Managed Database. (3rd Tier (Data Layer))

resource "aws_db_subnet_group" "oracle_subnets" {
  name       = "oracle-subnet-group"
  subnet_ids = [aws_subnet.data_1.id, aws_subnet.data_2.id]
}

resource "aws_db_instance" "oracle_db" {
  identifier             = "cloudstack-oracle"
  engine                 = "oracle-ee" # Oracle Enterprise Edition
  instance_class         = "db.t3.small"
  allocated_storage      = 20
  db_subnet_group_name   = aws_db_subnet_group.oracle_subnets.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
}
