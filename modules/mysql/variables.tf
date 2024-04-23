variable "environment" {
  description   = "The environment of the deployment"
  type          = string
}

variable "vpc_id" {
  description   = "The ID of the VPC"
  type          = string
}

variable "subnet_ids" {
  type          = list(string)
  description   = "The ids of the subnets" 
}

variable "storage_type" {
  type          = string
  description   = "Storage type for the mysql database"
  default       = "gp2"
}

variable "mysql_version" {
  type          = string
  description   = "Mysql engine version"
  default       = "8.0.35"
}

variable "mysql_instance_class" {
  type          = string
  description   = "Instance class to deploy the database to"
  default       = "db.t3.micro"
}

variable "mysql_db_identifier" {
  type          = string
  description   = "Identifier name of the database"
  default       = "mydb"
}

variable "mysql_username" {
  type          = string
  description   = "Username for the database"
  default       = "dbuser"
}

variable "mysql_password" {
  type          = string
  description   = "Password for the database"
  default       = "dbpassword"
}

variable "allocated_storage" {
  type          = number
  description   = "Size of the allocated storage for the database"
  default       = 10
}