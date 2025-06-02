# S3 Bucket for RDS Backups
module "s3" {
  source = "./s3"

  bucket_name = var.rds_backup_bucket_name
  
  # Enable versioning for backups
  enable_versioning = true
  
  # Block all public access
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
  # Create RDS backup folder structure
  create_rds_backup_folders = true
  rds_instance_identifiers  = var.rds_instance_identifiers
  
  # Lifecycle rules for backup management
  lifecycle_rules = var.rds_backup_lifecycle_rules
  
  tags = merge(
    var.tags,
    {
      Purpose = "RDS-Backups"
    }
  )
}

# FSx Windows File System
module "fsx" {
  source = "./fsx"

  vpc_id                          = var.vpc_id
  managed_ad_id                   = var.fsx_managed_ad_id
  private_subnet_id               = var.fsx_private_subnet_id
  security_group_id               = var.fsx_security_group_id
  name                            = var.fsx_name
  storage_capacity                = var.fsx_storage_capacity
  deployment_type                 = var.fsx_deployment_type
  throughput_capacity             = var.fsx_throughput_capacity
  storage_type                    = var.fsx_storage_type
  automatic_backup_retention_days = var.fsx_backup_retention_days
  copy_tags_to_backups            = var.fsx_copy_tags_to_backups
  daily_automatic_backup_start_time = var.fsx_daily_backup_time
  tags                            = var.tags
}

# RDS SQL Server
module "rds" {
  source = "./rds"

  vpc_id            = var.vpc_id
  subnet_ids        = var.rds_subnet_ids
  security_group_id = var.rds_security_group_id
  region            = var.region
  
  identifier           = var.rds_identifier
  db_subnet_group_name = var.rds_db_subnet_group_name
  parameter_group_name = var.rds_parameter_group_name
  option_group_name    = var.rds_option_group_name
  
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  major_engine_version = var.rds_major_engine_version
  instance_class       = var.rds_instance_class
  
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  storage_type          = var.rds_storage_type
  storage_encrypted     = var.rds_storage_encrypted
  
  username = var.rds_username
  password = var.rds_password
  
  multi_az             = var.rds_multi_az
  publicly_accessible  = false
  
  backup_retention_period = var.rds_backup_retention_period
  backup_window           = var.rds_backup_window
  maintenance_window      = var.rds_maintenance_window
  
  skip_final_snapshot  = var.rds_skip_final_snapshot
  deletion_protection  = var.rds_deletion_protection
  
  license_model        = var.rds_license_model
  domain_id            = var.rds_domain_id
  domain_iam_role_name = var.rds_domain_iam_role_name
  
  # Enhanced features
  monitoring_interval    = var.rds_monitoring_interval
  monitoring_role_arn    = var.rds_monitoring_role_arn
  
  performance_insights_enabled          = var.rds_performance_insights_enabled
  performance_insights_retention_period = var.rds_performance_insights_retention_period
  
  # CloudWatch Logs exports
  enabled_cloudwatch_logs_exports       = var.rds_enabled_cloudwatch_logs_exports
  cloudwatch_logs_retention_days        = var.rds_cloudwatch_logs_retention_days
  
  # SQL Server specific log settings
  enable_audit_log                      = var.rds_enable_audit_log
  enable_error_log                      = var.rds_enable_error_log
  enable_agent_log                      = var.rds_enable_agent_log
  
  # S3 import configuration
  enable_s3_import = var.rds_enable_s3_import
  s3_import_configuration = var.rds_s3_import_configuration
  
  auto_minor_version_upgrade = var.rds_auto_minor_version_upgrade
  apply_immediately = var.rds_apply_immediately
  copy_tags_to_snapshot = var.rds_copy_tags_to_snapshot
  
  db_parameters = var.rds_parameters
  db_options    = var.rds_options
  
  tags = var.tags
}