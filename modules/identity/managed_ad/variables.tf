variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the Managed AD"
  type        = string
}

variable "short_name" {
  description = "The NetBIOS name for the Managed AD"
  type        = string
  default     = null
}

variable "admin_password" {
  description = "The admin password for the Managed AD"
  type        = string
  sensitive   = true
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
  
  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "At least two private subnet IDs are required for Managed AD."
  }
}

variable "edition" {
  description = "The edition of the Managed AD (Standard or Enterprise)"
  type        = string
  default     = "Standard"
  
  validation {
    condition     = contains(["Standard", "Enterprise"], var.edition)
    error_message = "Edition must be either Standard or Enterprise."
  }
}

variable "enable_logs" {
  description = "Whether to enable logging for the Managed AD"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Number of days to retain logs"
  type        = number
  default     = 30
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Environment = "Stage"
  }
}