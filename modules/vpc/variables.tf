variable "cidr" {
    description = "The CIDR block for the VPC"
    type        = string
}

variable "environment" {
    description = "The environment of the deployment"
    type        = string
}

variable "public_subnets" {
    type = map(string)
    description = "Map of public subnets with cidr and az"

    default = {
        "10.0.1.0/24" = "us-east-1a"
        "10.0.2.0/24" = "us-east-1b"
        "10.0.3.0/24" = "us-east-1c"
    }
}

variable "private_subnets" {
    type = map(string)
    description = "Map of private subnets with cidr and az"

    default = {
        "10.0.4.0/24" = "us-east-1a"
        "10.0.5.0/24" = "us-east-1b"
        "10.0.6.0/24" = "us-east-1c"
        "10.0.7.0/24" = "us-east-1b"
    }
}