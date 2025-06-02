output "bucket_id" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_s3_bucket.main.arn
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = aws_s3_bucket.main.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name"
  value       = aws_s3_bucket.main.bucket_regional_domain_name
}

output "rds_backup_path" {
  description = "The path to RDS backups in the bucket"
  value       = var.create_rds_backup_folders ? "s3://${aws_s3_bucket.main.id}/rds-backups/" : null
}

output "rds_instance_backup_paths" {
  description = "Map of RDS instance identifiers to their backup paths"
  value = var.create_rds_backup_folders ? {
    for instance in var.rds_instance_identifiers :
    instance => "s3://${aws_s3_bucket.main.id}/rds-backups/${instance}/"
  } : {}
}