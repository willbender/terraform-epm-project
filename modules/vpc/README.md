# VPC Terraform module

Terraform module which creates a VPC with subnets and Internet Gateway on AWS.

## Usage

```hcl
module "vpc" {
  source            = "./modules/vpc"
  cidr              = var.cidr
  environment       = var.environment
  public_subnets    = var.public_subnets
  private_subnets   = var.private_subnets
}
```