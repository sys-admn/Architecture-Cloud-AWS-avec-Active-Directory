output "managed_ad_id" {
  description = "The ID of the Managed AD"
  value       = aws_directory_service_directory.main.id
}

output "managed_ad_name" {
  description = "The name of the Managed AD"
  value       = aws_directory_service_directory.main.name
}

output "managed_ad_dns_ip_addresses" {
  description = "The DNS IP addresses of the Managed AD"
  value       = aws_directory_service_directory.main.dns_ip_addresses
}

# Convert the set to a list to allow indexing
output "managed_ad_dns_ip_addresses_list" {
  description = "The DNS IP addresses of the Managed AD as a list"
  value       = tolist(aws_directory_service_directory.main.dns_ip_addresses)
}

output "managed_ad_security_group_id" {
  description = "The security group ID of the Managed AD"
  value       = aws_directory_service_directory.main.security_group_id
}

output "managed_ad_access_url" {
  description = "The access URL for the Managed AD"
  value       = aws_directory_service_directory.main.access_url
}