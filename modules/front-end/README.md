# Front-end Terraform module

Terraform module which creates an instance ready to deploy front end in a public subnet on AWS.

## Usage

```hcl
module "front_end" {
  source                      = "./modules/front-end"
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  ami                         = var.ami
  instance_type               = var.instance_type
  front_end_public_subnet_id  = module.vpc.vpc_public_subnet_ids[2]
  front_end_keypair           = var.key_name
}
```