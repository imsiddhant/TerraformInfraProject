# This is whatever Terraform Database module pukes

output "Database_Endpoint" {
  value = aws_db_instance.maindatabase.address
}