# This is whatever Terraform Database module pukes

output "Host" {
  value = aws_db_instance.maindatabase.address
}

output "dbname" {
  value = aws_db_instance.maindatabase.db_name
}

output "Username" {
  value = aws_db_instance.maindatabase.username
}

output "Password" {
  value = aws_db_instance.maindatabase.password
}

output "Port" {
  value = aws_db_instance.maindatabase.port
}

output "Name" {
  value = aws_db_instance.maindatabase.db_name
}
