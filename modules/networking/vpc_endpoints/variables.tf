variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "name_prefix" {
  description = "Prefix to use for resource names"
  type        = string
}

variable "create_rds_endpoint" {
  description = "Whether to create a VPC endpoint for RDS"
  type        = bool
  default     = false
}

variable "create_s3_endpoint" {
  description = "Whether to create an S3 VPC endpoint"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "List of subnet IDs for interface endpoints"
  type        = list(string)
  default     = []
}

variable "security_group_id" {
  description = "Security group ID for interface endpoints"
  type        = string
  default     = null
}

variable "private_route_table_id" {
  description = "ID of the private route table for gateway endpoints"
  type        = string
  default     = ""  # Changed from null to empty string
}

variable "public_route_table_id" {
  description = "ID of the public route table for gateway endpoints"
  type        = string
  default     = ""  # Changed from null to empty string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}