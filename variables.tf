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
  }
}

variable "storage_type" {
  description   = "Storage type for the mysql database"
  default       = "gp2"
}

variable "mysql_version" {
  description   = "Mysql engine version"
  default       = "8.0.35"
}

variable "mysql_instance_class" {
  description   = "Instance class to deploy the database to"
  default       = "db.t3.micro"
}

variable "mysql_db_identifier" {
  description   = "Identifier name of the database"
  default       = "moviedb"
}

variable "mysql_username" {
  description   = "Username for the database"
  default       = "applicationuser"
}

variable "mysql_password" {
  description   = "Password for the database"
  default       = "applicationuser"
}

variable "mysql_db_name" {
  description   = "Name of the created database"
  default       = "movie_db"
}

variable "allocated_storage" {
  description   = "Size of the allocated storage for the database"
  default       = 10
}

variable "key_name" {
  description   = "Name of the key par to use for the instances"
  default       = "william"
}

variable "ami" {
  description   = "Ami id to use with the ec2 instances"
  default       = "ami-07caf09b362be10b8"
}

variable "instance_type" {
  description   = "Type of instance to use for ec2"
  default       = "t2.micro"
}

variable "domain_name" {
  description   = "Domain name for the app"
  default       = "devops.cloud.epm.final"
}