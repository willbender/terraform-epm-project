output "instance_id" {
  description = "Id of the created instance."
  value       = aws_instance.bastion_instance.id
}

output "public_ip" {
  description = "Public ip of the created instance."
  value       = aws_instance.bastion_instance.public_ip
}