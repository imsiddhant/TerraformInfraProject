# This is whatever Terraform Networking module pukes

output "main_vpc_id" {
  value = aws_vpc.mainvpc
}

output "private_rt_id" {
  value = aws_route_table.PrivateRT
}

output "public_rt_id" {
  value = aws_route_table.PublicRT
}
