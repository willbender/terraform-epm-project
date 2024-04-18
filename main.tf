module "vpc" {
    source = "./modules/vpc"
    cidr = var.cidr
    environment = var.environment
}