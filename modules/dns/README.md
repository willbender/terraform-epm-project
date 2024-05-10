# Dns Terraform module

Terraform module which creates an dns zone on AWS.

## Usage

```hcl
module "dns" {
  source              = "./modules/dns"
  environment         = var.environment
  domain_name         = var.domain_name
  instance_public_ip  = module.front_end.public_ip
}
```