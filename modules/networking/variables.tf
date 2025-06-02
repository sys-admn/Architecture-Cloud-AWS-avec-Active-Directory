# VPC Configuration
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
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

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "region" {
  description = "The AWS region"
  type        = string
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

# VPC Endpoints
variable "create_s3_endpoint" {
  description = "Whether to create an S3 VPC endpoint"
  type        = bool
  default     = true
}

variable "create_rds_endpoint" {
  description = "Whether to create a VPC endpoint for RDS"
  type        = bool
  default     = false
}

# Security Group Names
variable "ad_security_group_name" {
  description = "Name of the security group for Active Directory"
  type        = string
}

variable "fsx_security_group_name" {
  description = "Name of the security group for FSx"
  type        = string
}

variable "ec2_security_group_name" {
  description = "Name of the security group for EC2 instances"
  type        = string
}

variable "route53_security_group_name" {
  description = "Name of the security group for Route53 Resolver"
  type        = string
}

variable "rds_security_group_name" {
  description = "Name of the security group for RDS"
  type        = string
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

# Route53 Configuration
variable "domain_name" {
  description = "The domain name for DNS resolution"
  type        = string
}

variable "route53_endpoint_name" {
  description = "Name of the Route53 outbound endpoint"
  type        = string
}

variable "resolver_rule_name" {
  description = "Name of the Route53 resolver rule"
  type        = string
}

variable "create_resolver_rule" {
  description = "Whether to create a Route53 resolver rule"
  type        = bool
  default     = true
}

variable "dns_ip_addresses" {
  description = "List of DNS IP addresses for Route53 resolver"
  type        = list(object({
    ip   = string
    port = optional(number, 53)
  }))
  default     = []
}

# Common
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}