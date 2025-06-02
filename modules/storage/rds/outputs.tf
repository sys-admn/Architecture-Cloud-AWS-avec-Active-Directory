output "db_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.main.id
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.main.address
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.main.db_name != null ? aws_db_instance.main.db_name : "MSSQL"
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = aws_db_instance.main.username
  sensitive   = true
}

output "db_instance_port" {
  description = "The database port"
  value       = aws_db_instance.main.port
}

output "db_subnet_group_id" {
  description = "The db subnet group name"
  value       = aws_db_subnet_group.main.id
}

output "db_parameter_group_id" {
  description = "The db parameter group name"
  value       = aws_db_parameter_group.main.id
}

output "db_option_group_id" {
  description = "The db option group name"
  value       = aws_db_option_group.main.id
}

output "cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created for RDS logs"
  value       = { for k, v in aws_cloudwatch_log_group.rds_logs : k => v.name }
}

output "enabled_log_types" {
  description = "List of log types enabled for export to CloudWatch"
  value       = var.enabled_cloudwatch_logs_exports
}