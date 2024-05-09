resource "aws_security_group" "sg_bastion" {
  name          = "${var.environment}-sg-bastion-instance"
  description   = "Security Group for Bastion Host instance"
  vpc_id        = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-sg-bastion-instance"
  }
}

resource "aws_iam_role" "ec2_instances_rol" {
  name  = "${var.environment}-ec2-instances-rol"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
EOF
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name  = "${var.environment}-bastion-profile"
  role  = aws_iam_role.ec2_instances_rol.name
}

resource "aws_iam_role_policy" "ec2_full_access" {
  name    = "${var.environment}-ec2_full_access"
  role    = aws_iam_role.ec2_instances_rol.id
  policy  = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "autoscaling.amazonaws.com",
                        "ec2scheduled.amazonaws.com",
                        "elasticloadbalancing.amazonaws.com",
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com",
                        "transitgateway.amazonaws.com"
                    ]
                }
            }
        }
    ]
  })
}

resource "aws_instance" "bastion_instance" {
  ami                           = var.ami
  instance_type                 = var.instance_type
  subnet_id                     = var.bastion_public_subnet_id
  vpc_security_group_ids        = [aws_security_group.sg_bastion.id]
  associate_public_ip_address   = true
  key_name                      = var.bastion_keypair
  iam_instance_profile          = aws_iam_instance_profile.bastion_profile.name

  user_data = <<EOF
  #!/bin/bash
  sudo yum install -y ansible
  sudo yum install -y python3-pip
  sudo pip3 install boto3
  EOF

  tags  = {
    Name = "${var.environment}-bastion-instance"
  }
}