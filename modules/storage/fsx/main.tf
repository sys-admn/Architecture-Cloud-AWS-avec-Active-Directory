resource "aws_fsx_windows_file_system" "main" {
  storage_capacity    = var.storage_capacity
  subnet_ids          = [var.private_subnet_id]
  deployment_type     = var.deployment_type
  throughput_capacity = var.throughput_capacity
  active_directory_id = var.managed_ad_id
  security_group_ids  = [var.security_group_id]
  
  automatic_backup_retention_days = var.automatic_backup_retention_days
  copy_tags_to_backups            = var.copy_tags_to_backups
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  
  storage_type = var.storage_type
  
  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}