module "vpc" {
    source = "./modules/vpc"
    cidr = var.cidr
    environment = var.environment
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
}