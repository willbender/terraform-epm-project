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