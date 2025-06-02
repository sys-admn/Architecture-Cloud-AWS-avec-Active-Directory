# Common
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

# EC2 Configuration
variable "ec2_instances" {
  type = map(object({
    ami                         = string
    type                        = string
    subnet_id                   = string
    associate_public_ip_address = bool
    key_name                    = string
    vpc_security_group_id       = string
    iam_instance_profile        = string
    tags                        = map(string)
    user_data                   = optional(string)
    user_data_replace_on_change = optional(bool)
    root_volume_size            = optional(number)
    root_volume_type            = optional(string)
    ebs_block_devices = optional(list(object({
      device_name           = string
      volume_size           = number
      volume_type           = optional(string)
      encrypted             = optional(bool)
      delete_on_termination = optional(bool)
    })), [])
  }))
  description = "Map of EC2 instances to create"
  default     = {}
}

# Bastion Configuration
variable "bastion_enabled" {
  description = "Whether to create a bastion host"
  type        = bool
  default     = false
}

variable "bastion_config" {
  description = "Configuration for the bastion host"
  type        = any
  default     = {}
}

# Instance Settings
variable "enable_monitoring" {
  description = "Enable detailed monitoring for EC2 instances"
  type        = bool
  default     = true
}

variable "enable_ebs_optimization" {
  description = "Enable EBS optimization for EC2 instances"
  type        = bool
  default     = true
}

variable "http_put_response_hop_limit" {
  description = "The desired HTTP PUT response hop limit for instance metadata requests"
  type        = number
  default     = 1
}