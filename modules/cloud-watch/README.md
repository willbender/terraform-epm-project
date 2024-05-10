# Cloudwatch Terraform module

Terraform module which creates a cloudwatch dashboard and an alarm for a given instance on AWS.

## Usage

```hcl
module "cloud_watch" {
  source      = "./modules/cloud-watch"
  environment = var.environment
  instance_id = module.front_end.instance_id
}
```