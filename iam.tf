resource "aws_iam_role" "ec2_app_role" {
  name = "cloudstack-ec2-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "CloudStack-EC2-App-Role"
  }
}

resource "aws_iam_policy" "ec2_s3_policy" {
  name        = "cloudstack-ec2-s3-policy"
  description = "Allow EC2 instances to write logs to S3 bucket only"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.data_bucket.arn}",
          "${aws_s3_bucket.data_bucket.arn}/*"
        ]
        Condition = {
          StringEquals = {
            "s3:prefix" = [
              "logs/",
              "backups/"
            ]
          }
        }
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.data_bucket.arn
        ]
      }
    ]
  })

  tags = {
    Name = "CloudStack-EC2-S3-Policy"
  }
}

resource "aws_iam_policy" "ec2_cloudwatch_policy" {
  name        = "cloudstack-ec2-cloudwatch-policy"
  description = "Allow EC2 instances to write logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups"
        ]
        Resource = [
          "arn:aws:logs:*:*:log-group:/aws/ec2/cloudstack-app-*",
          "arn:aws:logs:*:*:log-group:/aws/ec2/cloudstack-app-*:log-stream:*"
        ]
      }
    ]
  })

  tags = {
    Name = "CloudStack-EC2-CloudWatch-Policy"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_s3_attachment" {
  role       = aws_iam_role.ec2_app_role.name
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
}

resource "aws_iam_role_policy_attachment" "ec2_cloudwatch_attachment" {
  role       = aws_iam_role.ec2_app_role.name
  policy_arn = aws_iam_policy.ec2_cloudwatch_policy.arn
}

resource "aws_iam_instance_profile" "ec2_app_profile" {
  name = "cloudstack-ec2-app-profile"
  role = aws_iam_role.ec2_app_role.name
}

resource "aws_iam_role" "bastion_role" {
  name = "cloudstack-bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "CloudStack-Bastion-Role"
  }
}

resource "aws_iam_policy" "bastion_policy" {
  name        = "cloudstack-bastion-policy"
  description = "Read-only access for bastion host management"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeVolumes",
          "ec2:DescribeSnapshots"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "CloudStack-Bastion-Policy"
  }
}

resource "aws_iam_role_policy_attachment" "bastion_attachment" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = aws_iam_policy.bastion_policy.arn
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "cloudstack-bastion-profile"
  role = aws_iam_role.bastion_role.name
}

resource "aws_iam_role" "load_generator_role" {
  name = "cloudstack-load-generator-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "CloudStack-Load-Generator-Role"
  }
}

resource "aws_iam_policy" "load_generator_policy" {
  name        = "cloudstack-load-generator-policy"
  description = "Load testing permissions for load generator"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeVolumes",
          "ec2:DescribeSnapshots"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "CloudStack-Load-Generator-Policy"
  }
}

resource "aws_iam_role_policy_attachment" "load_generator_attachment" {
  role       = aws_iam_role.load_generator_role.name
  policy_arn = aws_iam_policy.load_generator_policy.arn
}

resource "aws_iam_instance_profile" "load_generator_profile" {
  name = "cloudstack-load-generator-profile"
  role = aws_iam_role.load_generator_role.name
}
