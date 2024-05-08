variable "environment" {
  description   = "The environment of the deployment"
  type          = string
}

variable "vpc_id" {
  description   = "The ID of the VPC"
  type          = string
}

variable "elb_subnets" {
  type          = list(string)
  description   = "The ids of the subnets for the elb" 
}

variable "ami" {
  description   = "AMI for the instances"
  type          = string
}

variable "instance_type" {
  description   = "Type of instance for the EC2s"
  type          = string
}

variable "key_name" {
  description   = "Key name to access to the instances"
  type          = string
}