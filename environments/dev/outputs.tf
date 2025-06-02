output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.windows_ad_infrastructure.vpc_id
}

output "managed_ad_id" {
  description = "The ID of the Managed AD"
  value       = module.windows_ad_infrastructure.managed_ad_id
}

output "managed_ad_access_url" {
  description = "The access URL for the Managed AD"
  value       = module.windows_ad_infrastructure.managed_ad_access_url
}

output "fsx_dns_name" {
  description = "The DNS name of the FSx file system"
  value       = module.windows_ad_infrastructure.fsx_dns_name
}

output "rds_instance_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.windows_ad_infrastructure.rds_instance_endpoint
}

output "bastion_public_ip" {
  description = "Public IP of the bastion instance"
  value       = module.windows_ad_infrastructure.bastion_public_ip
}

output "ec2_instance_ids" {
  description = "Map of EC2 instance names to their IDs"
  value       = module.windows_ad_infrastructure.ec2_instance_ids
}

output "rds_backup_bucket_id" {
  description = "The name of the RDS backup bucket"
  value       = module.windows_ad_infrastructure.rds_backup_bucket_id
}