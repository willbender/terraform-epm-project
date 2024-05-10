output "address" {
  description = "Address of the mysql instance"
  value       = aws_db_instance.mysql_db.address
}