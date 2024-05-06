resource "aws_security_group" "sg_front_end" {
  name          = "${var.environment}-sg-front-end-instance"
  description   = "Security Group for Front End instance"
  vpc_id        = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 3030
    to_port     = 3030
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-sg-front-end-instance"
  }
}

resource "aws_instance" "front_end_instance" {
  ami                           = var.ami
  instance_type                 = var.instance_type
  subnet_id                     = var.front_end_public_subnet_id
  vpc_security_group_ids        = [aws_security_group.sg_front_end.id]
  associate_public_ip_address   = true
  key_name                      = var.front_end_keypair

  tags  = {
    Name = "${var.environment}-front-end-instance"
  }
}