# Environment
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

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
  default     = "windows-ad-vpc-dev"
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
  default     = "dev.corp.example.com"
}

variable "short_name" {
  description = "The NetBIOS name for the Managed AD"
  type        = string
  default     = "DEVCORP"
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
  default     = "dev-corp-file-share"
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
  default     = {
    "windows-server-dev" = {
      ami                         = "ami-0c765d44cf1f25d26" # Windows Server 2019
      type                        = "t3.medium"
      associate_public_ip_address = false
      key_name                    = "windows-key-dev"
      create_eip                  = false
      root_volume_size            = 50
      root_volume_type            = "gp3"
      tags                        = {
        Role = "Domain Member"
        Name = "Windows Server Dev"
      }
    },
    "bastion" = {
      ami                         = "ami-05f08ad7b78afd8cd" # Amazon Linux 2
      type                        = "t3.micro"
      associate_public_ip_address = true
      key_name                    = "bastion-key-dev"
      create_eip                  = true
      eip_name                    = "Bastion-EIP-Dev"
      root_volume_size            = 30
      root_volume_type            = "gp3"
      tags                        = {
        Role = "Bastion Host"
        Name = "Bastion Host Dev"
      }
    }
  }
}

# IAM Configuration
variable "ec2_role_name" {
  description = "Name of the IAM role for EC2"
  type        = string
  default     = "windows-ec2-role-dev"
}

variable "ec2_instance_profile_name" {
  description = "Name of the IAM instance profile for EC2"
  type        = string
  default     = "windows-ec2-profile-dev"
}

variable "policy_arns" {
  description = "List of policy ARNs to attach to the EC2 role"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
  ]
}

variable "create_custom_policy" {
  description = "Whether to create a custom policy for the EC2 role"
  type        = bool
  default     = false
}

# Security Group Names
variable "ad_security_group_name" {
  description = "Name of the security group for Active Directory"
  type        = string
  default     = "ad-security-group-dev"
}

variable "fsx_security_group_name" {
  description = "Name of the security group for FSx"
  type        = string
  default     = "fsx-security-group-dev"
}

variable "ec2_security_group_name" {
  description = "Name of the security group for EC2 instances"
  type        = string
  default     = "ec2-security-group-dev"
}

variable "route53_security_group_name" {
  description = "Name of the security group for Route53 Resolver"
  type        = string
  default     = "route53-security-group-dev"
}

variable "rds_security_group_name" {
  description = "Name of the security group for RDS"
  type        = string
  default     = "rds-security-group-dev"
}

# Route53 Configuration
variable "route53_endpoint_name" {
  description = "Name of the Route53 outbound endpoint"
  type        = string
  default     = "ad-dns-outbound-dev"
}

variable "route53_resolver_rule_name" {
  description = "Name of the Route53 resolver rule"
  type        = string
  default     = "ad-dns-forward-dev"
}

variable "create_resolver_rule" {
  description = "Whether to create a Route53 resolver rule"
  type        = bool
  default     = true
}

# RDS Configuration - Basic Settings
variable "rds_ad_auth_role_name" {
  description = "Name of the IAM role for RDS AD authentication"
  type        = string
  default     = "rds-ad-auth-role-dev"
}

variable "rds_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
  default     = "sqlserver-db-dev"
}

variable "rds_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
  default     = "sqlserver-subnet-group-dev"
}

variable "rds_parameter_group_name" {
  description = "Name of the DB parameter group"
  type        = string
  default     = "sqlserver-param-group-dev"
}

variable "rds_option_group_name" {
  description = "Name of the DB option group"
  type        = string
  default     = "sqlserver-option-group-dev"
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
  default     = "gp3"
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
  default     = true
}

variable "rds_deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}

variable "rds_license_model" {
  description = "License model for this DB instance"
  type        = string
  default     = "license-included"
}

variable "rds_parameters" {
  description = "A list of DB parameters to apply"
  type        = list(map(string))
  default     = [
    {
      name  = "contained database authentication"
      value = "1"
    }
  ]
}

variable "rds_options" {
  description = "A list of DB options to apply"
  type        = any
  default     = []
}

variable "create_rds_vpc_endpoint" {
  description = "Whether to create a VPC endpoint for RDS"
  type        = bool
  default     = true
}

# RDS Enhanced Monitoring
variable "rds_enable_enhanced_monitoring" {
  description = "Whether to enable enhanced monitoring for RDS"
  type        = bool
  default     = true
}

variable "rds_monitoring_role_name" {
  description = "Name of the IAM role for RDS enhanced monitoring"
  type        = string
  default     = "rds-monitoring-role-dev"
}

variable "rds_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  type        = number
  default     = 60
}

# RDS Performance Insights
variable "rds_enable_performance_insights" {
  description = "Whether to enable Performance Insights for RDS"
  type        = bool
  default     = true
}

variable "rds_performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data"
  type        = number
  default     = 7
}

# RDS S3 Integration
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
    },
    {
      id              = "expire-old-backups"
      status          = "Enabled"
      expiration_days = 365
    }
  ]
}

variable "rds_enable_s3_import" {
  description = "Whether to enable S3 import for RDS"
  type        = bool
  default     = true
}

variable "rds_s3_import_configuration" {
  description = "Configuration for S3 import"
  type        = map(string)
  default     = {
    source_engine         = "sqlserver"
    source_engine_version = "15.00"
  }
}

# RDS CloudWatch Logs Export
variable "rds_enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. For SQL Server: agent, error, audit"
  type        = list(string)
  default     = ["error", "agent", "audit"]
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
  default     = true
}

variable "rds_enable_error_log" {
  description = "Enable SQL Server error log"
  type        = bool
  default     = true
}

variable "rds_enable_agent_log" {
  description = "Enable SQL Server agent log"
  type        = bool
  default     = true
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
  default     = true
}

variable "rds_copy_tags_to_snapshot" {
  description = "Copy all Instance tags to snapshots"
  type        = bool
  default     = true
}

# Global Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Project     = "Windows-AD-Infrastructure"
    ManagedBy   = "Terraform"
    Owner       = "IT-Infrastructure"
  }
}