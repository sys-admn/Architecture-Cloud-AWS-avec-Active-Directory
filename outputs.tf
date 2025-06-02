# Networking Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.networking.private_subnet_ids
}

# Identity Outputs
output "managed_ad_id" {
  description = "The ID of the Managed AD"
  value       = module.identity.managed_ad_id
}

output "managed_ad_dns_ip_addresses" {
  description = "The DNS IP addresses of the Managed AD"
  value       = module.identity.managed_ad_dns_ip_addresses
}

output "managed_ad_access_url" {
  description = "The access URL for the Managed AD"
  value       = module.identity.managed_ad_access_url
}

# Route53 Resolver Rule Outputs
output "route53_resolver_rule_id" {
  description = "The ID of the Route53 Resolver rule"
  value       = var.create_resolver_rule ? module.route53_resolver_rule.resolver_rule_id : null
}

output "route53_endpoint_id" {
  description = "The ID of the Route53 Resolver endpoint"
  value       = module.networking.route53_endpoint_id
}

# Storage Outputs
output "fsx_id" {
  description = "The ID of the FSx file system"
  value       = module.storage.fsx_id
}

output "fsx_dns_name" {
  description = "The DNS name of the FSx file system"
  value       = module.storage.fsx_dns_name
}

output "rds_instance_id" {
  description = "The RDS instance ID"
  value       = module.storage.rds_instance_id
}

output "rds_instance_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.storage.rds_instance_endpoint
}

output "rds_backup_bucket_id" {
  description = "The name of the RDS backup bucket"
  value       = module.storage.rds_backup_bucket_id
}

# Compute Outputs
output "ec2_instance_ids" {
  description = "Map of EC2 instance names to their IDs"
  value       = module.compute.instance_ids
}

output "bastion_public_ip" {
  description = "Public IP of the bastion instance"
  value       = module.compute.bastion_public_ip
}

output "bastion_eip_public_ip" {
  description = "Public IP of the bastion Elastic IP"
  value       = module.compute.bastion_eip_public_ip
}