resource "aws_vpc" "main" {
    cidr_block = var.cidr
    tags = {
        Name = "vpc-${var.environment}"
        Environment = var.environment
    }
}