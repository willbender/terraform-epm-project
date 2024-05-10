# Create a VPC with private subnets, public subnets (with internet gateway) and the route tables
module "vpc" {
  source            = "./modules/vpc"
  cidr              = var.cidr
  environment       = var.environment
  public_subnets    = var.public_subnets
  private_subnets   = var.private_subnets
}

#Create a mysql database server with a database inside via aws rds
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

#Create a NAT instance to use it instaed a nat gateway
module "nat" {
  source                      = "./modules/nat"
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  vpc_cidr_block              = module.vpc.vpc_cidr_block
  private_subnet_cidr_blocks  = module.vpc.private_cidr_blocks
  nat_public_subnet_id        = module.vpc.vpc_public_subnet_ids[0]
  nat_keypair                 = var.key_name
}

#Create a bastion host in a public subnet
module "bastion_host" {
  source                    = "./modules/bastion-host"
  environment               = var.environment
  vpc_id                    = module.vpc.vpc_id
  ami                       = var.ami
  instance_type             = var.instance_type
  bastion_public_subnet_id  = module.vpc.vpc_public_subnet_ids[1]
  bastion_keypair           = var.key_name
}

#Create a frontend host in a public subnet
module "front_end" {
  source                      = "./modules/front-end"
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  ami                         = var.ami
  instance_type               = var.instance_type
  front_end_public_subnet_id  = module.vpc.vpc_public_subnet_ids[2]
  front_end_keypair           = var.key_name
}

#Create dns
module "dns" {
  source              = "./modules/dns"
  environment         = var.environment
  domain_name         = var.domain_name
  instance_public_ip  = module.front_end.public_ip
}

#Create a load balancer for backend, together with an auto scaling group for the creation of backend instances
module "back_end" {
  source        = "./modules/back-end"
  environment   = var.environment
  vpc_id        = module.vpc.vpc_id
  elb_subnets   = module.vpc.vpc_private_subnet_ids
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
}

#Route to enable the instances on private subnets to reach the internet via nat instance
resource "aws_route" "outbound-nat-route" {
  route_table_id         = module.vpc.private_rt_id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = module.nat.nat_network_interface_id
}

#Create cloud watch dashboard for the frontend instance
module "cloud_watch" {
  source      = "./modules/cloud-watch"
  environment = var.environment
  instance_id = module.front_end.instance_id
}