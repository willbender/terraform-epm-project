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

resource "aws_instance" "bastion_instance" {
  ami                           = var.ami
  instance_type                 = var.instance_type
  subnet_id                     = var.bastion_public_subnet_id
  vpc_security_group_ids        = [aws_security_group.sg_bastion.id]
  associate_public_ip_address   = true
  key_name                      = var.bastion_keypair

  user_data = <<EOF
  #!/bin/bash
  sudo yum install -y ansible
  EOF

  tags  = {
    Name = "${var.environment}-bastion-instance"
  }
}