output "bastion_ip" {
  description = "Public ip of the bastion instance."
  value       = module.bastion_host.public_ip
}