# AWS Region
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# VPC Configuration
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "windows-ad-vpc"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 2
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default     = 2
}

variable "create_nat_gateway" {
  description = "Whether to create a NAT Gateway"
  type        = bool
  default     = true
}

variable "enable_flow_logs" {
  description = "Whether to enable VPC flow logs"
  type        = bool
  default     = true
}

variable "flow_log_retention_days" {
  description = "Number of days to retain flow logs"
  type        = number
  default     = 30
}

variable "create_s3_endpoint" {
  description = "Whether to create an S3 VPC endpoint"
  type        = bool
  default     = true
}

# Managed AD Configuration
variable "domain_name" {
  description = "The domain name for the Managed AD"
  type        = string
  default     = "corp.example.com"
}

variable "short_name" {
  description = "The NetBIOS name for the Managed AD"
  type        = string
  default     = "CORP"
}

variable "admin_password" {
  description = "The admin password for the Managed AD"
  type        = string
  sensitive   = true
}

variable "ad_edition" {
  description = "The edition of the Managed AD (Standard or Enterprise)"
  type        = string
  default     = "Standard"
}

variable "enable_ad_logs" {
  description = "Whether to enable logging for the Managed AD"
  type        = bool
  default     = true
}

variable "ad_log_retention_days" {
  description = "Number of days to retain AD logs"
  type        = number
  default     = 30
}

# FSx Configuration
variable "fsx_name" {
  description = "The name of the FSx file system"
  type        = string
  default     = "corp-file-share"
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

# EC2 Instances
variable "instances" {
  description = "Map of EC2 instances to create"
  type        = any
  default     = {}
}

# IAM Configuration
variable "ec2_role_name" {
  description = "Name of the IAM role for EC2"
  type        = string
  default     = "windows-ec2-role"
}

variable "ec2_instance_profile_name" {
  description = "Name of the IAM instance profile for EC2"
  type        = string
  default     = "windows-ec2-profile"
}

variable "policy_arns" {
  description = "List of policy ARNs to attach to the EC2 role"
  type        = list(string)
  default     = []
}

variable "create_custom_policy" {
  description = "Whether to create a custom policy for the EC2 role"
  type        = bool
  default     = false
}

variable "custom_policy_document" {
  description = "Custom policy document for the EC2 role"
  type        = string
  default     = ""
}

# Security Group Names
variable "ad_security_group_name" {
  description = "Name of the security group for Active Directory"
  type        = string
  default     = "ad-security-group"
}

variable "fsx_security_group_name" {
  description = "Name of the security group for FSx"
  type        = string
  default     = "fsx-security-group"
}

variable "ec2_security_group_name" {
  description = "Name of the security group for EC2 instances"
  type        = string
  default     = "ec2-security-group"
}

variable "route53_security_group_name" {
  description = "Name of the security group for Route53 Resolver"
  type        = string
  default     = "route53-security-group"
}

variable "rds_security_group_name" {
  description = "Name of the security group for RDS"
  type        = string
  default     = "rds-security-group"
}

# Route53 Configuration
variable "route53_endpoint_name" {
  description = "Name of the Route53 outbound endpoint"
  type        = string
  default     = "ad-dns-outbound"
}

variable "route53_resolver_rule_name" {
  description = "Name of the Route53 resolver rule"
  type        = string
  default     = "ad-dns-forward"
}

variable "create_resolver_rule" {
  description = "Whether to create a Route53 resolver rule"
  type        = bool
  default     = true
}

# Port Configuration
variable "ldap_port" {
  description = "LDAP port"
  type        = number
  default     = 389
}

variable "ldaps_port" {
  description = "LDAPS port"
  type        = number
  default     = 636
}

variable "dns_port" {
  description = "DNS port"
  type        = number
  default     = 53
}

variable "smb_port" {
  description = "SMB port"
  type        = number
  default     = 445
}

variable "rdp_port" {
  description = "RDP port"
  type        = number
  default     = 3389
}

variable "mssql_port" {
  description = "Microsoft SQL Server port"
  type        = number
  default     = 1433
}

# RDS Configuration - Basic Settings
variable "rds_ad_auth_role_name" {
  description = "Name of the IAM role for RDS AD authentication"
  type        = string
  default     = "rds-ad-auth-role"
}

variable "rds_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
  default     = "sqlserver-db"
}

variable "rds_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
  default     = "sqlserver-subnet-group"
}

variable "rds_parameter_group_name" {
  description = "Name of the DB parameter group"
  type        = string
  default     = "sqlserver-param-group"
}

variable "rds_option_group_name" {
  description = "Name of the DB option group"
  type        = string
  default     = "sqlserver-option-group"
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

variable "create_rds_vpc_endpoint" {
  description = "Whether to create a VPC endpoint for RDS"
  type        = bool
  default     = false
}

# RDS Enhanced Monitoring
variable "rds_enable_enhanced_monitoring" {
  description = "Whether to enable enhanced monitoring for RDS"
  type        = bool
  default     = false
}

variable "rds_monitoring_role_name" {
  description = "Name of the IAM role for RDS enhanced monitoring"
  type        = string
  default     = "rds-monitoring-role"
}

variable "rds_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  type        = number
  default     = 0
}

# RDS Performance Insights
variable "rds_enable_performance_insights" {
  description = "Whether to enable Performance Insights for RDS"
  type        = bool
  default     = false
}

variable "rds_performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data"
  type        = number
  default     = 7
}

# RDS S3 Integration
variable "rds_enable_s3_backup" {
  description = "Whether to enable S3 backups for RDS (Note: Only valid for RDS on Outposts, not used in standard RDS deployments)"
  type        = bool
  default     = false
}

variable "rds_backup_role_name" {
  description = "Name of the IAM role for RDS backups"
  type        = string
  default     = "rds-backup-role"
}

variable "rds_backup_bucket_name" {
  description = "Name of the S3 bucket for RDS backups"
  type        = string
  default     = "rds-sql-server-backups"
}

variable "rds_backup_lifecycle_rules" {
  description = "Lifecycle rules for the RDS backup bucket"
  type        = any
  default     = [
    {
      id     = "transition-to-ia"
      status = "Enabled"
      transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        }
      ]
    },
    {
      id     = "transition-to-glacier"
      status = "Enabled"
      transitions = [
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
    }
  ]
}

variable "rds_backup_bucket_arns" {
  description = "List of S3 bucket ARNs where RDS backups will be stored"
  type        = list(string)
  default     = []
}

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

variable "rds_cloudwatch_logs_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting RDS CloudWatch log data"
  type        = string
  default     = null
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

# Global Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}