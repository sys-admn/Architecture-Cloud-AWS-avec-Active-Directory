output "fsx_id" {
  description = "The ID of the FSx file system"
  value       = aws_fsx_windows_file_system.main.id
}

output "fsx_dns_name" {
  description = "The DNS name for the FSx file system"
  value       = aws_fsx_windows_file_system.main.dns_name
}

output "fsx_network_interface_ids" {
  description = "The network interface IDs of the FSx file system"
  value       = aws_fsx_windows_file_system.main.network_interface_ids
}

output "fsx_vpc_id" {
  description = "The VPC ID of the FSx file system"
  value       = aws_fsx_windows_file_system.main.vpc_id
}