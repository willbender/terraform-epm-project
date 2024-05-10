output "bastion_ip" {
  description = "Public ip of the bastion instance."
  value       = module.bastion_host.public_ip
}

output "backend_dns" {
  description = "Dns name of the backend elb."
  value       = module.back_end.elb_dns
}

output "mysql_address" {
  description = "Address of the mysql instance"
  value       = module.mysql.address
}

output "frontend_ip" {
  description = "Public Ip Address of the frontend instance"
  value       = module.front_end.public_ip
}