#Create a security group for the nat instance
resource "aws_security_group" "sg_nat_instance" {
  name          = "${var.environment}-sg-nat-instance"
  description   = "Security Group for NAT instance"
  vpc_id        = var.vpc_id
  tags = {
    Name = "${var.environment}-sg-nat-instance"
  }
}

#Create a security group for the provate subnet
resource "aws_security_group" "sg_private_subnet" {
  name          = "${var.environment}-sg-private-subnet"
  description   = "Security Group for private instances"
  vpc_id        = var.vpc_id
  tags = {
    Name = "${var.environment}-sg-private-subnet"
  }
}

#Create a rule for the inbound traffic from the vpc
resource "aws_security_group_rule" "vpc_inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.vpc_cidr_block]
  security_group_id = aws_security_group.sg_nat_instance.id 
}

#Create a rule for the outbound traffic for the nat instance
resource "aws_security_group_rule" "outbound_nat_instance" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_nat_instance.id 
}

#Create a rule for the inbound traffic for the private subnet
resource "aws_security_group_rule" "private_subnet_inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.private_subnet_cidr_blocks
  security_group_id = aws_security_group.sg_nat_instance.id 
}

#Create a rule for the outbound traffic for the private subnet
resource "aws_security_group_rule" "outbound_private_subnet" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_private_subnet.id 
}

#Define the ami to use for the nat instance - This ami is special to create a nat instance
data "aws_ami" "fck_nat_amzn2" {
  most_recent   = true
  filter {
    name    = "name"
    values  = ["fck-nat-amzn2-hvm-1.2.1*-x86_64-ebs"]
  }
  filter {
    name    = "owner-id"
    values  = ["568608671756"]
  }
}

#Create the nat instance in a public subnet with the defined ami
resource "aws_instance" "nat_instance" {
  ami                           = data.aws_ami.fck_nat_amzn2.id
  instance_type                 = "t2.micro"
  subnet_id                     = var.nat_public_subnet_id
  vpc_security_group_ids        = [aws_security_group.sg_nat_instance.id]
  associate_public_ip_address   = true
  source_dest_check             = false
  key_name                      = var.nat_keypair

  root_block_device {
    volume_size = "2"
    volume_type = "gp2"
    encrypted   = true
  }

  tags  = {
    Name = "${var.environment}-nat-instance"
  }
}