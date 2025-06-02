# EC2 Role Variables
variable "ec2_role_name" {
  description = "Name of the IAM role for EC2"
  type        = string
}

variable "ec2_instance_profile_name" {
  description = "Name of the IAM instance profile for EC2"
  type        = string
}

variable "ec2_policy_arns" {
  description = "List of policy ARNs to attach to the EC2 role"
  type        = list(string)
  default     = []
}

variable "create_ec2_custom_policy" {
  description = "Whether to create a custom policy for the EC2 role"
  type        = bool
  default     = false
}

variable "ec2_custom_policy_document" {
  description = "Custom policy document for the EC2 role"
  type        = string
  default     = ""
}

# RDS AD Auth Role Variables
variable "create_rds_ad_auth_role" {
  description = "Whether to create an IAM role for RDS AD authentication"
  type        = bool
  default     = false
}

variable "rds_ad_auth_role_name" {
  description = "Name of the IAM role for RDS AD authentication"
  type        = string
  default     = "rds-ad-auth-role"
}

# RDS Monitoring Role Variables
variable "create_rds_monitoring_role" {
  description = "Whether to create an IAM role for RDS enhanced monitoring"
  type        = bool
  default     = false
}

variable "rds_monitoring_role_name" {
  description = "Name of the IAM role for RDS enhanced monitoring"
  type        = string
  default     = "rds-monitoring-role"
}

# RDS Backup Role Variables
variable "create_rds_backup_role" {
  description = "Whether to create an IAM role for RDS backups to S3"
  type        = bool
  default     = false
}

variable "rds_backup_role_name" {
  description = "Name of the IAM role for RDS backups"
  type        = string
  default     = "rds-backup-role"
}

variable "rds_backup_bucket_arns" {
  description = "List of S3 bucket ARNs where RDS backups will be stored"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}