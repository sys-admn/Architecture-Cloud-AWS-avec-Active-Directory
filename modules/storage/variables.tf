# Common
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

# S3 Configuration
variable "rds_backup_bucket_name" {
  description = "Name of the S3 bucket for RDS backups"
  type        = string
}

variable "rds_backup_lifecycle_rules" {
  description = "Lifecycle rules for the RDS backup bucket"
  type        = any
  default     = []
}

variable "rds_instance_identifiers" {
  description = "List of RDS instance identifiers for which to create backup folders"
  type        = list(string)
  default     = []
}

# FSx Configuration
variable "fsx_name" {
  description = "The name of the FSx file system"
  type        = string
}

variable "fsx_managed_ad_id" {
  description = "The ID of the Managed AD"
  type        = string
}

variable "fsx_private_subnet_id" {
  description = "The ID of the private subnet for FSx"
  type        = string
}

variable "fsx_security_group_id" {
  description = "The security group ID for FSx"
  type        = string
}

variable "fsx_storage_capacity" {
  description = "The storage capacity of the FSx file system in GiB"
  type        = number
  default     = 100
}

variable "fsx_deployment_type" {
  description = "The deployment type of the FSx file system"
  type        = string
  default     = "SINGLE_AZ_1"
}

variable "fsx_throughput_capacity" {
  description = "The throughput capacity of the FSx file system in MB/s"
  type        = number
  default     = 32
}

variable "fsx_storage_type" {
  description = "The storage type of the FSx file system"
  type        = string
  default     = "SSD"
}

variable "fsx_backup_retention_days" {
  description = "The number of days to retain backups of the FSx file system"
  type        = number
  default     = 7
}

variable "fsx_copy_tags_to_backups" {
  description = "Whether to copy tags to backups of the FSx file system"
  type        = bool
  default     = true
}

variable "fsx_daily_backup_time" {
  description = "The daily time to start automatic backups of the FSx file system"
  type        = string
  default     = "02:00"
}

# RDS Configuration
variable "rds_security_group_id" {
  description = "Security group ID for the RDS instance"
  type        = string
}

variable "rds_subnet_ids" {
  description = "List of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "rds_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "rds_db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "rds_parameter_group_name" {
  description = "Name of the DB parameter group"
  type        = string
}

variable "rds_option_group_name" {
  description = "Name of the DB option group"
  type        = string
}

variable "rds_engine" {
  description = "The database engine"
  type        = string
  default     = "sqlserver-se"
}

variable "rds_engine_version" {
  description = "The engine version"
  type        = string
  default     = "15.00.4236.7.v1"
}

variable "rds_major_engine_version" {
  description = "The major engine version"
  type        = string
  default     = "15.00"
}

variable "rds_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.m5.large"
}

variable "rds_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 100
}

variable "rds_max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale the storage"
  type        = number
  default     = 1000
}

variable "rds_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  type        = string
  default     = "gp2"
}

variable "rds_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "rds_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "admin"
}

variable "rds_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "rds_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "rds_backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "rds_backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = "03:00-06:00"
}

variable "rds_maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "rds_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "rds_deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = true
}

variable "rds_license_model" {
  description = "License model for this DB instance"
  type        = string
  default     = "license-included"
}

variable "rds_domain_id" {
  description = "The ID of the Directory Service Active Directory domain to create the instance in"
  type        = string
}

variable "rds_domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service"
  type        = string
}

variable "rds_parameters" {
  description = "A list of DB parameters to apply"
  type        = list(map(string))
  default     = []
}

variable "rds_options" {
  description = "A list of DB options to apply"
  type        = any
  default     = []
}

# RDS Enhanced Monitoring
variable "rds_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  type        = number
  default     = 0
}

variable "rds_monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = string
  default     = null
}

# RDS Performance Insights
variable "rds_performance_insights_enabled" {
  description = "Whether to enable Performance Insights for RDS"
  type        = bool
  default     = false
}

variable "rds_performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data"
  type        = number
  default     = 7
}

# RDS CloudWatch Logs Export
variable "rds_enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. For SQL Server: agent, error, audit"
  type        = list(string)
  default     = []
}

variable "rds_cloudwatch_logs_retention_days" {
  description = "The number of days to retain CloudWatch logs for RDS"
  type        = number
  default     = 30
}

# SQL Server specific log settings
variable "rds_enable_audit_log" {
  description = "Enable SQL Server audit log"
  type        = bool
  default     = false
}

variable "rds_enable_error_log" {
  description = "Enable SQL Server error log"
  type        = bool
  default     = false
}

variable "rds_enable_agent_log" {
  description = "Enable SQL Server agent log"
  type        = bool
  default     = false
}

# RDS S3 Integration
variable "rds_enable_s3_import" {
  description = "Whether to enable S3 import for RDS"
  type        = bool
  default     = false
}

variable "rds_s3_import_configuration" {
  description = "Configuration for S3 import"
  type        = map(string)
  default     = {}
}

# RDS Additional Settings
variable "rds_auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "rds_apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "rds_copy_tags_to_snapshot" {
  description = "Copy all Instance tags to snapshots"
  type        = bool
  default     = true
}