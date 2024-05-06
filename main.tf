module "vpc" {
  source            = "./modules/vpc"
  cidr              = var.cidr
  environment       = var.environment
  public_subnets    = var.public_subnets
  private_subnets   = var.private_subnets
}

module "mysql" {
  source                = "./modules/mysql"
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.vpc_private_subnet_ids
  storage_type          = var.storage_type
  mysql_version         = var.mysql_version
  mysql_instance_class  = var.mysql_instance_class
  mysql_db_identifier   = var.mysql_db_identifier
  mysql_username        = var.mysql_username
  mysql_password        = var.mysql_password
  allocated_storage     = var.allocated_storage
}

module "nat" {
  source                      = "./modules/nat"
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  vpc_cidr_block              = module.vpc.vpc_cidr_block
  private_subnet_cidr_blocks  = module.vpc.private_cidr_blocks
  nat_public_subnet_id        = module.vpc.vpc_public_subnet_ids[0]
  nat_keypair                 = var.key_name
}

module "bastion_host" {
  source                    = "./modules/bastion-host"
  environment               = var.environment
  vpc_id                    = module.vpc.vpc_id
  ami                       = var.ami
  instance_type             = var.instance_type
  bastion_public_subnet_id  = module.vpc.vpc_public_subnet_ids[1]
  bastion_keypair           = var.key_name
}

module "front_end" {
  source                      = "./modules/front-end"
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  ami                         = var.ami
  instance_type               = var.instance_type
  front_end_public_subnet_id  = module.vpc.vpc_public_subnet_ids[2]
  front_end_keypair           = var.key_name
}

module "dns" {
  source              = "./modules/dns"
  environment         = var.environment
  domain_name         = var.domain_name
  instance_public_ip  = module.front_end.public_ip
}