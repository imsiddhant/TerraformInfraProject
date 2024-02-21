# This is whatever Terraform Compute module pukes

output "ASG_ARN" {
  value = aws_autoscaling_group.ProdASG.arn
}

output "ALB_ARN" {
  value = aws_lb.ProdLB.arn
}