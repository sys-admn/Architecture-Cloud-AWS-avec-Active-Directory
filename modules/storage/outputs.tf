# S3 Outputs
output "rds_backup_bucket_id" {
  description = "The name of the RDS backup bucket"
  value       = module.s3.bucket_id
}

output "rds_backup_bucket_arn" {
  description = "The ARN of the RDS backup bucket"
  value       = module.s3.bucket_arn
}

output "rds_backup_path" {
  description = "The path to RDS backups in the bucket"
  value       = module.s3.rds_backup_path
}

output "rds_instance_backup_paths" {
  description = "Map of RDS instance identifiers to their backup paths"
  value       = module.s3.rds_instance_backup_paths
}

# FSx Outputs
output "fsx_id" {
  description = "The ID of the FSx file system"
  value       = module.fsx.fsx_id
}

output "fsx_dns_name" {
  description = "The DNS name of the FSx file system"
  value       = module.fsx.fsx_dns_name
}

output "fsx_network_interface_ids" {
  description = "The network interface IDs of the FSx file system"
  value       = module.fsx.fsx_network_interface_ids
}

# RDS Outputs
output "rds_instance_id" {
  description = "The RDS instance ID"
  value       = module.rds.db_instance_id
}

output "rds_instance_address" {
  description = "The address of the RDS instance"
  value       = module.rds.db_instance_address
}

output "rds_instance_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "rds_instance_name" {
  description = "The database name"
  value       = module.rds.db_instance_name
}

output "rds_instance_port" {
  description = "The database port"
  value       = module.rds.db_instance_port
}

output "rds_subnet_group_id" {
  description = "The db subnet group name"
  value       = module.rds.db_subnet_group_id
}

output "rds_parameter_group_id" {
  description = "The db parameter group name"
  value       = module.rds.db_parameter_group_id
}

output "rds_option_group_id" {
  description = "The db option group name"
  value       = module.rds.db_option_group_id
}

# RDS CloudWatch Logs Outputs
output "rds_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created for RDS logs"
  value       = module.rds.cloudwatch_log_groups
}

output "rds_enabled_log_types" {
  description = "List of log types enabled for export to CloudWatch"
  value       = module.rds.enabled_log_types
}