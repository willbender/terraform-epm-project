# Back-end Terraform module

Terraform module which creates a load balancer and an autoscaling group for the creation of back instances in private subnets on AWS.

## Usage

```hcl
module "back_end" {
  source        = "./modules/back-end"
  environment   = var.environment
  vpc_id        = module.vpc.vpc_id
  elb_subnets   = module.vpc.vpc_private_subnet_ids
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
}
```