# Bastion host Terraform module

Terraform module which creates a bastion host instance with ansible and mysql ready to configure the rest of the environment on AWS.

## Usage

```hcl
module "bastion_host" {
  source                    = "./modules/bastion-host"
  environment               = var.environment
  vpc_id                    = module.vpc.vpc_id
  ami                       = var.ami
  instance_type             = var.instance_type
  bastion_public_subnet_id  = module.vpc.vpc_public_subnet_ids[1]
  bastion_keypair           = var.key_name
}
```