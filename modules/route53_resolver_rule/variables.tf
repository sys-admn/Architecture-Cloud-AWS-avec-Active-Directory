variable "create_resolver_rule" {
  description = "Whether to create a Route53 Resolver rule"
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "The domain name for the Managed AD"
  type        = string
}

variable "resolver_rule_name" {
  description = "The name of the Route53 Resolver rule"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "resolver_endpoint_id" {
  description = "The ID of the Route53 Resolver endpoint"
  type        = string
}

variable "target_ip_addresses" {
  description = "List of target IP addresses for the Route53 Resolver rule"
  type        = list(object({
    ip   = string
    port = optional(number, 53)
  }))
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}