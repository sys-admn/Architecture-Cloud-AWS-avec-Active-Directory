output "rds_endpoint_id" {
  description = "The ID of the RDS VPC endpoint"
  value       = var.create_rds_endpoint ? aws_vpc_endpoint.rds[0].id : null
}

output "rds_endpoint_dns_entry" {
  description = "The DNS entries for the RDS VPC endpoint"
  value       = var.create_rds_endpoint ? aws_vpc_endpoint.rds[0].dns_entry : null
}

output "s3_endpoint_id" {
  description = "The ID of the S3 VPC endpoint"
  value       = var.create_s3_endpoint ? aws_vpc_endpoint.s3[0].id : null
}