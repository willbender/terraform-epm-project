variable "region" {
  description = "The region to deploy the resources into"
  default     = "us-east-1"
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "The environment this resources are beeing deployed to"
  default     = "qa"
}

variable "public_subnets" {
  description = "The public subnets configuration inside the vpc"
  default = {
        "10.0.1.0/24" = "us-east-1a"
        "10.0.2.0/24" = "us-east-1b"
        "10.0.3.0/24" = "us-east-1c"
  }
}

variable "private_subnets" {
  description = "The private subnets configuration inside the vpc"
  default = {
        "10.0.4.0/24" = "us-east-1a"
        "10.0.5.0/24" = "us-east-1b"
        "10.0.6.0/24" = "us-east-1c"
        "10.0.7.0/24" = "us-east-1d"
  }
}