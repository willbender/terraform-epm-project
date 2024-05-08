output "nat_network_interface_id" {
  description = "The ID of NAT network interface"
  value       = aws_instance.nat_instance.primary_network_interface_id
}