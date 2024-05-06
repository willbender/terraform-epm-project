variable "environment" {
  description   = "The environment of the deployment"
  type          = string
}

variable "vpc_id" {
  description   = "The ID of the VPC"
  type          = string
}

variable "ami" {
  description   = "AMI for the instances"
  type          = string
}

variable "instance_type" {
  description   = "Type of instance for the EC2s"
  type          = string
}

variable "bastion_public_subnet_id" {
  description   = "Id of the public subnet to deploy the bastion to"
  type          = string
}

variable "bastion_keypair" {
  description   = "Name of the key par to use for the bastion"
  type          = string
}