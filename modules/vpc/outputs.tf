output "vpc_id" {
    description = "The ID of the VPC"
    value       = aws_vpc.main.id
}

output "vpc_public_subnets" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = {
    for subnet in aws_subnet.public :
    subnet.id => subnet.cidr_block
  }
}

output "vpc_private_subnets" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = {
    for subnet in aws_subnet.private :
    subnet.id => subnet.cidr_block
  }
}