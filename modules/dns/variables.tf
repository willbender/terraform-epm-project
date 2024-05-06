variable "environment" {
  description   = "The environment of the deployment"
  type          = string
}

variable "domain_name" {
  description   = "The domain name of the deployment"
  type          = string
}

variable "instance_public_ip" {
  description   = "The Public ip of the instance for the record"
  type          = string
}