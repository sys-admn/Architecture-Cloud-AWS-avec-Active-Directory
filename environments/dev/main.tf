provider "aws" {
  region = var.region
}

module "windows_ad_infrastructure" {
  source = "../../"
  
  # AWS Region
  region = var.region

  # VPC Configuration
  vpc_cidr_block = var.vpc_cidr_block
  vpc_name = var.vpc_name
  availability_zones = var.availability_zones
  public_subnet_count = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  create_nat_gateway = var.create_nat_gateway
  enable_flow_logs = var.enable_flow_logs
  flow_log_retention_days = var.flow_log_retention_days
  create_s3_endpoint = var.create_s3_endpoint

  # Managed AD Configuration
  domain_name = var.domain_name
  short_name = var.short_name
  admin_password = var.admin_password
  ad_edition = var.ad_edition
  enable_ad_logs = var.enable_ad_logs
  ad_log_retention_days = var.ad_log_retention_days

  # FSx Configuration
  fsx_name = var.fsx_name
  fsx_storage_capacity = var.fsx_storage_capacity
  fsx_deployment_type = var.fsx_deployment_type
  fsx_throughput_capacity = var.fsx_throughput_capacity
  fsx_storage_type = var.fsx_storage_type
  fsx_backup_retention_days = var.fsx_backup_retention_days
  fsx_copy_tags_to_backups = var.fsx_copy_tags_to_backups
  fsx_daily_backup_time = var.fsx_daily_backup_time

  # EC2 Instances
  instances = var.instances

  # IAM Configuration
  ec2_role_name = var.ec2_role_name
  ec2_instance_profile_name = var.ec2_instance_profile_name
  policy_arns = var.policy_arns
  create_custom_policy = var.create_custom_policy

  # Security Group Names
  ad_security_group_name = var.ad_security_group_name
  fsx_security_group_name = var.fsx_security_group_name
  ec2_security_group_name = var.ec2_security_group_name
  route53_security_group_name = var.route53_security_group_name
  rds_security_group_name = var.rds_security_group_name

  # Route53 Configuration
  route53_endpoint_name = var.route53_endpoint_name
  route53_resolver_rule_name = var.route53_resolver_rule_name
  create_resolver_rule = var.create_resolver_rule

  # RDS Configuration
  rds_ad_auth_role_name = var.rds_ad_auth_role_name
  rds_identifier = var.rds_identifier
  rds_subnet_group_name = var.rds_subnet_group_name
  rds_parameter_group_name = var.rds_parameter_group_name
  rds_option_group_name = var.rds_option_group_name
  rds_engine = var.rds_engine
  rds_engine_version = var.rds_engine_version
  rds_major_engine_version = var.rds_major_engine_version
  rds_instance_class = var.rds_instance_class
  rds_allocated_storage = var.rds_allocated_storage
  rds_max_allocated_storage = var.rds_max_allocated_storage
  rds_storage_type = var.rds_storage_type
  rds_storage_encrypted = var.rds_storage_encrypted
  rds_username = var.rds_username
  rds_password = var.rds_password
  rds_multi_az = var.rds_multi_az
  rds_backup_retention_period = var.rds_backup_retention_period
  rds_backup_window = var.rds_backup_window
  rds_maintenance_window = var.rds_maintenance_window
  rds_skip_final_snapshot = var.rds_skip_final_snapshot
  rds_deletion_protection = var.rds_deletion_protection
  rds_license_model = var.rds_license_model
  
  # RDS Enhanced Features
  rds_enable_enhanced_monitoring = var.rds_enable_enhanced_monitoring
  rds_monitoring_role_name = var.rds_monitoring_role_name
  rds_monitoring_interval = var.rds_monitoring_interval
  rds_enable_performance_insights = var.rds_enable_performance_insights
  rds_performance_insights_retention_period = var.rds_performance_insights_retention_period
  
  # RDS CloudWatch Logs Export
  rds_enabled_cloudwatch_logs_exports = var.rds_enabled_cloudwatch_logs_exports
  rds_cloudwatch_logs_retention_days = var.rds_cloudwatch_logs_retention_days
  rds_enable_audit_log = var.rds_enable_audit_log
  rds_enable_error_log = var.rds_enable_error_log
  rds_enable_agent_log = var.rds_enable_agent_log
  
  # RDS S3 Integration
  rds_backup_bucket_name = "${var.rds_backup_bucket_name}-${var.environment}"
  rds_backup_lifecycle_rules = var.rds_backup_lifecycle_rules
  rds_enable_s3_import = var.rds_enable_s3_import
  rds_s3_import_configuration = var.rds_s3_import_configuration
  
  # RDS Additional Settings
  rds_auto_minor_version_upgrade = var.rds_auto_minor_version_upgrade
  rds_apply_immediately = var.rds_apply_immediately
  rds_copy_tags_to_snapshot = var.rds_copy_tags_to_snapshot
  rds_parameters = var.rds_parameters
  rds_options = var.rds_options
  
  # VPC Endpoints
  create_rds_vpc_endpoint = var.create_rds_vpc_endpoint
  
  # Global Tags
  tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}