#Create the main VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr
  tags = {
      Name        = "vpc-${var.environment}"
      Environment = var.environment
  }
}

#Create an internet gateway associated with the vpc
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-internet-gateway"
  }
}

#Create a route table for the private subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-private-route-table"
  }
}

#Create a route table for the public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-public-route-table"
  }
}

#Create a route for public subnets, so they can reach the internet gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

#Create as many public subnets as specified with the given cidr blocks
resource "aws_subnet" "public" {
  for_each = var.public_subnets
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value

  cidr_block = each.key

  tags = {
    Name        = "${var.environment}-public-subnet"
    Role        = "public"
    Environment = var.environment
    Subnet      = "${each.value}-${each.key}"
  }
}

#Create as many private subnets as specified with the given cidr blocks
resource "aws_subnet" "private" {
  for_each = var.private_subnets
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value

  cidr_block = each.key

  tags = {
    Name        = "${var.environment}-private-subnet"
    Role        = "public"
    Environment = var.environment
    Subnet      = "${each.value}-${each.key}"
  }
}

/* Route table association for public subnets */
resource "aws_route_table_association" "public" {
  for_each        = aws_subnet.public
  subnet_id       = each.value.id
  route_table_id  = aws_route_table.public_rt.id
}

/* Route table association for private subnets */
resource "aws_route_table_association" "private" {
  for_each        = aws_subnet.private
  subnet_id       = each.value.id
  route_table_id  = aws_route_table.private_rt.id
}