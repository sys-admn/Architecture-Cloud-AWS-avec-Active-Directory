# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks of public subnets"
  value       = module.vpc.public_subnet_cidr_blocks
}

output "private_subnet_cidr_blocks" {
  description = "List of CIDR blocks of private subnets"
  value       = module.vpc.private_subnet_cidr_blocks
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = module.vpc.nat_gateway_id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = module.vpc.public_route_table_id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = module.vpc.private_route_table_id
}

# Security Group Outputs
output "ad_security_group_id" {
  description = "The ID of the Active Directory security group"
  value       = module.ad_security_group.security_group_id
}

output "fsx_security_group_id" {
  description = "The ID of the FSx security group"
  value       = module.fsx_security_group.security_group_id
}

output "ec2_security_group_id" {
  description = "The ID of the EC2 security group"
  value       = module.ec2_security_group.security_group_id
}

output "route53_security_group_id" {
  description = "The ID of the Route53 security group"
  value       = module.route53_security_group.security_group_id
}

output "rds_security_group_id" {
  description = "The ID of the RDS security group"
  value       = module.rds_security_group.security_group_id
}

# Route53 Outputs
output "route53_endpoint_id" {
  description = "The ID of the Route53 Resolver endpoint"
  value       = module.route53.route53_endpoint_id
}

output "route53_endpoint_ip_addresses" {
  description = "The IP addresses of the Route53 Resolver endpoint"
  value       = module.route53.route53_endpoint_ip_addresses
}

# VPC Endpoints Outputs
output "s3_endpoint_id" {
  description = "The ID of the S3 VPC endpoint"
  value       = module.vpc_endpoints.s3_endpoint_id
}

output "rds_endpoint_id" {
  description = "The ID of the RDS VPC endpoint"
  value       = module.vpc_endpoints.rds_endpoint_id
}

output "rds_endpoint_dns_entry" {
  description = "The DNS entries for the RDS VPC endpoint"
  value       = module.vpc_endpoints.rds_endpoint_dns_entry
}