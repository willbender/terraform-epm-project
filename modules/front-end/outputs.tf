output "instance_id" {
  description = "Id of the created instance."
  value       = aws_instance.front_end_instance.id
}

output "public_ip" {
  description = "Public ip of the created instance."
  value       = aws_instance.front_end_instance.public_ip
}