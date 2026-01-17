resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/aws/ec2/cloudstack-app"
  retention_in_days = 14

  tags = {
    Name = "CloudStack-App-Logs"
  }
}

resource "aws_cloudwatch_log_group" "bastion_logs" {
  name              = "/aws/ec2/cloudstack-bastion"
  retention_in_days = 30

  tags = {
    Name = "CloudStack-Bastion-Logs"
  }
}
