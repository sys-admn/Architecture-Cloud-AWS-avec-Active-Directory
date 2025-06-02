variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the RDS instance"
  type        = string
}

variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group"
  type        = string
}

variable "parameter_group_family" {
  description = "Family of the DB parameter group"
  type        = string
  default     = "sqlserver-se-15.0"
}

variable "option_group_name" {
  description = "Name of the DB option group"
  type        = string
}

variable "engine" {
  description = "The database engine"
  type        = string
  default     = "sqlserver-se"
}

variable "engine_version" {
  description = "The engine version"
  type        = string
  default     = "15.00.4236.7.v1"
}

variable "major_engine_version" {
  description = "The major engine version"
  type        = string
  default     = "15.00"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.m5.large"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 100
}

variable "max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale the storage"
  type        = number
  default     = 1000
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = "03:00-06:00"
}

variable "maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = true
}

variable "license_model" {
  description = "License model for this DB instance"
  type        = string
  default     = "license-included"
}

variable "domain_id" {
  description = "The ID of the Directory Service Active Directory domain to create the instance in"
  type        = string
}

variable "domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service"
  type        = string
}

variable "db_parameters" {
  description = "A list of DB parameters to apply"
  type        = list(map(string))
  default     = []
}

variable "db_options" {
  description = "A list of DB options to apply"
  type        = any
  default     = []
}

variable "region" {
  description = "The AWS region"
  type        = string
}

# Enhanced monitoring settings
variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable, set to 0."
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = string
  default     = null
}

# Performance Insights
variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years)."
  type        = number
  default     = 7
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type        = string
  default     = null
}

# S3 import
variable "enable_s3_import" {
  description = "Enable S3 import functionality"
  type        = bool
  default     = false
}

variable "s3_import_configuration" {
  description = "Configuration for S3 import"
  type        = map(string)
  default     = {}
}

# Additional settings
variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Instance tags to snapshots"
  type        = bool
  default     = true
}

# CloudWatch Logs exports
variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. For SQL Server: agent, error"
  type        = list(string)
  default     = []
  
  validation {
    condition = alltrue([
      for log_type in var.enabled_cloudwatch_logs_exports :
      contains(["agent", "error", "audit"], log_type)
    ])
    error_message = "Valid values for SQL Server are: agent, error, audit."
  }
}

variable "cloudwatch_logs_retention_days" {
  description = "The number of days to retain CloudWatch logs"
  type        = number
  default     = 30
}

variable "cloudwatch_logs_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting CloudWatch log data"
  type        = string
  default     = null
}

# SQL Server specific log settings
variable "enable_audit_log" {
  description = "Enable SQL Server audit log"
  type        = bool
  default     = false
}

variable "enable_error_log" {
  description = "Enable SQL Server error log"
  type        = bool
  default     = false
}

variable "enable_agent_log" {
  description = "Enable SQL Server agent log"
  type        = bool
  default     = false
}

variable "create_vpc_endpoint" {
  description = "Whether to create a VPC endpoint for RDS"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}