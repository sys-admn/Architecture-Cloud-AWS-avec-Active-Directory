# Managed AD Outputs
output "managed_ad_id" {
  description = "The ID of the Managed AD"
  value       = module.managed_ad.managed_ad_id
}

output "managed_ad_name" {
  description = "The name of the Managed AD"
  value       = module.managed_ad.managed_ad_name
}

output "managed_ad_dns_ip_addresses" {
  description = "The DNS IP addresses of the Managed AD"
  value       = module.managed_ad.managed_ad_dns_ip_addresses
}

output "managed_ad_dns_ip_addresses_list" {
  description = "The DNS IP addresses of the Managed AD as a list"
  value       = module.managed_ad.managed_ad_dns_ip_addresses_list
}

output "managed_ad_security_group_id" {
  description = "The security group ID of the Managed AD"
  value       = module.managed_ad.managed_ad_security_group_id
}

output "managed_ad_access_url" {
  description = "The access URL for the Managed AD"
  value       = module.managed_ad.managed_ad_access_url
}

# EC2 IAM Role Outputs
output "ec2_role_id" {
  description = "The ID of the EC2 IAM role"
  value       = module.iam.ec2_role_id
}

output "ec2_role_name" {
  description = "The name of the EC2 IAM role"
  value       = module.iam.ec2_role_name
}

output "ec2_role_arn" {
  description = "The ARN of the EC2 IAM role"
  value       = module.iam.ec2_role_arn
}

output "ec2_instance_profile_id" {
  description = "The ID of the EC2 IAM instance profile"
  value       = module.iam.ec2_instance_profile_id
}

output "ec2_instance_profile_name" {
  description = "The name of the EC2 IAM instance profile"
  value       = module.iam.ec2_instance_profile_name
}

output "ec2_instance_profile_arn" {
  description = "The ARN of the EC2 IAM instance profile"
  value       = module.iam.ec2_instance_profile_arn
}

# RDS AD Auth Role Outputs
output "rds_ad_auth_role_id" {
  description = "The ID of the RDS AD authentication IAM role"
  value       = module.iam.rds_ad_auth_role_id
}

output "rds_ad_auth_role_name" {
  description = "The name of the RDS AD authentication IAM role"
  value       = module.iam.rds_ad_auth_role_name
}

output "rds_ad_auth_role_arn" {
  description = "The ARN of the RDS AD authentication IAM role"
  value       = module.iam.rds_ad_auth_role_arn
}

# RDS Monitoring Role Outputs
output "rds_monitoring_role_id" {
  description = "The ID of the RDS monitoring IAM role"
  value       = module.iam.rds_monitoring_role_id
}

output "rds_monitoring_role_name" {
  description = "The name of the RDS monitoring IAM role"
  value       = module.iam.rds_monitoring_role_name
}

output "rds_monitoring_role_arn" {
  description = "The ARN of the RDS monitoring IAM role"
  value       = module.iam.rds_monitoring_role_arn
}

# RDS Backup Role Outputs
output "rds_backup_role_id" {
  description = "The ID of the RDS backup IAM role"
  value       = module.iam.rds_backup_role_id
}

output "rds_backup_role_name" {
  description = "The name of the RDS backup IAM role"
  value       = module.iam.rds_backup_role_name
}

output "rds_backup_role_arn" {
  description = "The ARN of the RDS backup IAM role"
  value       = module.iam.rds_backup_role_arn
}