# Mysql Terraform module

Terraform module which creates a Mysql Instance and a database on it on AWS.

## Usage

```hcl
module "mysql" {
  source                = "./modules/mysql"
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.vpc_private_subnet_ids
  storage_type          = var.storage_type
  mysql_version         = var.mysql_version
  mysql_instance_class  = var.mysql_instance_class
  mysql_db_identifier   = var.mysql_db_identifier
  mysql_db_name         = var.mysql_db_name
  mysql_username        = var.mysql_username
  mysql_password        = var.mysql_password
  allocated_storage     = var.allocated_storage
}
```