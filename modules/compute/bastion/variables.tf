variable "name" {
  description = "Name of the bastion host"
  type        = string
  default     = "bastion"
}

variable "ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID where the bastion host will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the bastion host"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for the bastion host"
  type        = string
}

variable "enable_monitoring" {
  description = "Enable detailed monitoring for the bastion host"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "User data script for the bastion host"
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "Whether to replace the instance when user_data changes"
  type        = bool
  default     = false
}

variable "http_put_response_hop_limit" {
  description = "The desired HTTP PUT response hop limit for instance metadata requests"
  type        = number
  default     = 1
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 30
}

variable "root_volume_type" {
  description = "Type of the root volume"
  type        = string
  default     = "gp3"
}

variable "create_eip" {
  description = "Whether to create an Elastic IP for the bastion host"
  type        = bool
  default     = true
}

variable "eip_name" {
  description = "Name of the Elastic IP"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}