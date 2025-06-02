output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.main.id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = aws_security_group.main.name
}

output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = aws_security_group.main.vpc_id
}