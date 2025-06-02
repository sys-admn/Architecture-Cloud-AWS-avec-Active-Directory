# EC2 Role Outputs
output "ec2_role_id" {
  description = "The ID of the EC2 IAM role"
  value       = aws_iam_role.ec2.id
}

output "ec2_role_name" {
  description = "The name of the EC2 IAM role"
  value       = aws_iam_role.ec2.name
}

output "ec2_role_arn" {
  description = "The ARN of the EC2 IAM role"
  value       = aws_iam_role.ec2.arn
}

output "ec2_instance_profile_id" {
  description = "The ID of the EC2 IAM instance profile"
  value       = aws_iam_instance_profile.ec2.id
}

output "ec2_instance_profile_name" {
  description = "The name of the EC2 IAM instance profile"
  value       = aws_iam_instance_profile.ec2.name
}

output "ec2_instance_profile_arn" {
  description = "The ARN of the EC2 IAM instance profile"
  value       = aws_iam_instance_profile.ec2.arn
}

# RDS AD Auth Role Outputs
output "rds_ad_auth_role_id" {
  description = "The ID of the RDS AD authentication IAM role"
  value       = var.create_rds_ad_auth_role ? aws_iam_role.rds_ad_auth[0].id : null
}

output "rds_ad_auth_role_name" {
  description = "The name of the RDS AD authentication IAM role"
  value       = var.create_rds_ad_auth_role ? aws_iam_role.rds_ad_auth[0].name : null
}

output "rds_ad_auth_role_arn" {
  description = "The ARN of the RDS AD authentication IAM role"
  value       = var.create_rds_ad_auth_role ? aws_iam_role.rds_ad_auth[0].arn : null
}

# RDS Monitoring Role Outputs
output "rds_monitoring_role_id" {
  description = "The ID of the RDS monitoring IAM role"
  value       = var.create_rds_monitoring_role ? aws_iam_role.rds_monitoring[0].id : null
}

output "rds_monitoring_role_name" {
  description = "The name of the RDS monitoring IAM role"
  value       = var.create_rds_monitoring_role ? aws_iam_role.rds_monitoring[0].name : null
}

output "rds_monitoring_role_arn" {
  description = "The ARN of the RDS monitoring IAM role"
  value       = var.create_rds_monitoring_role ? aws_iam_role.rds_monitoring[0].arn : null
}

# RDS Backup Role Outputs
output "rds_backup_role_id" {
  description = "The ID of the RDS backup IAM role"
  value       = var.create_rds_backup_role ? aws_iam_role.rds_backup[0].id : null
}

output "rds_backup_role_name" {
  description = "The name of the RDS backup IAM role"
  value       = var.create_rds_backup_role ? aws_iam_role.rds_backup[0].name : null
}

output "rds_backup_role_arn" {
  description = "The ARN of the RDS backup IAM role"
  value       = var.create_rds_backup_role ? aws_iam_role.rds_backup[0].arn : null
}