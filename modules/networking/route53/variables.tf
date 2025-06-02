variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
  
  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "At least two private subnet IDs are required for Route53 Resolver endpoint."
  }
}

variable "domain_name" {
  description = "The domain name for the Managed AD"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID to associate with the Route53 Resolver endpoint"
  type        = string
}

variable "endpoint_name" {
  description = "The name of the Route53 Resolver endpoint"
  type        = string
  default     = "outbound-endpoint"
}

variable "resolver_rule_name" {
  description = "The name of the Route53 Resolver rule"
  type        = string
  default     = "forward-rule"
}

variable "create_resolver_rule" {
  description = "Whether to create a Route53 Resolver rule"
  type        = bool
  default     = true
}

variable "target_ip_addresses" {
  description = "List of target IP addresses for the Route53 Resolver rule"
  type        = list(object({
    ip   = string
    port = optional(number, 53)
  }))
  default     = []
}

variable "ip_addresses" {
  description = "Map of subnet index to specific IP address to use in that subnet"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Environment = "Stage"
  }
}