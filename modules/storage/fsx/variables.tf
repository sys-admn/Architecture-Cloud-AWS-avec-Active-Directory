variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "managed_ad_id" {
  description = "The ID of the Managed AD"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID to associate with the FSx"
  type        = string
}

variable "name" {
  description = "Name of the FSx file system"
  type        = string
  default     = "windows-fsx"
}

variable "storage_capacity" {
  description = "Storage capacity of the FSx file system in GiB"
  type        = number
  default     = 80
}

variable "deployment_type" {
  description = "The deployment type of the FSx file system (MULTI_AZ_1, SINGLE_AZ_1, or SINGLE_AZ_2)"
  type        = string
  default     = "SINGLE_AZ_1"
  
  validation {
    condition     = contains(["MULTI_AZ_1", "SINGLE_AZ_1", "SINGLE_AZ_2"], var.deployment_type)
    error_message = "Deployment type must be one of MULTI_AZ_1, SINGLE_AZ_1, or SINGLE_AZ_2."
  }
}

variable "throughput_capacity" {
  description = "Throughput capacity of the FSx file system in MB/s"
  type        = number
  default     = 32
}

variable "storage_type" {
  description = "Storage type for the file system. SSD or HDD"
  type        = string
  default     = "SSD"
  
  validation {
    condition     = contains(["SSD", "HDD"], var.storage_type)
    error_message = "Storage type must be either SSD or HDD."
  }
}

variable "automatic_backup_retention_days" {
  description = "The number of days to retain automatic backups"
  type        = number
  default     = 7
  
  validation {
    condition     = var.automatic_backup_retention_days >= 0 && var.automatic_backup_retention_days <= 90
    error_message = "Automatic backup retention days must be between 0 and 90."
  }
}

variable "copy_tags_to_backups" {
  description = "Whether to copy tags to backups"
  type        = bool
  default     = true
}

variable "daily_automatic_backup_start_time" {
  description = "The daily time to start automatic backups in the format HH:MM"
  type        = string
  default     = "02:00"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Environment = "Stage"
  }
}