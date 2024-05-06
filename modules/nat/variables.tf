variable "environment" {
  description   = "The environment of the deployment"
  type          = string
}

variable "vpc_id" {
  description   = "The ID of the VPC"
  type          = string
}

variable "vpc_cidr_block" {
  description   = "Cidr block of the VPC"
  type          = string
}

variable "private_subnet_cidr_blocks" {
  description   = "Cidr blocks of the private subnets"
  type          = list
}

variable "nat_public_subnet_id" {
  description   = "Id of the public subnet to deploy the nat to"
  type          = string
}

variable "nat_keypair" {
  description   = "Name of the key par to use for the nat"
  type          = string
}