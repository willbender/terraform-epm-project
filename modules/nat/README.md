# NAT Terraform module

Terraform module which creates a NAT Instance on a public subnet on AWS.

## Usage

```hcl
module "nat" {
  source                      = "./modules/nat"
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  vpc_cidr_block              = module.vpc.vpc_cidr_block
  private_subnet_cidr_blocks  = module.vpc.private_cidr_blocks
  nat_public_subnet_id        = module.vpc.vpc_public_subnet_ids[0]
  nat_keypair                 = var.key_name
}

#Route to enable the instances on private subnets to reach the internet via nat instance
resource "aws_route" "outbound-nat-route" {
  route_table_id         = module.vpc.private_rt_id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = module.nat.nat_network_interface_id
}
```