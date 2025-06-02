# IAM Roles
module "iam" {
  source = "./iam"

  # EC2 IAM Role
  ec2_role_name             = var.ec2_role_name
  ec2_instance_profile_name = var.ec2_instance_profile_name
  ec2_policy_arns           = var.ec2_policy_arns
  create_ec2_custom_policy  = var.create_ec2_custom_policy
  ec2_custom_policy_document = var.ec2_custom_policy_document
  
  # RDS AD Auth Role
  create_rds_ad_auth_role = var.create_rds_ad_auth_role
  rds_ad_auth_role_name   = var.rds_ad_auth_role_name
  
  # RDS Monitoring Role
  create_rds_monitoring_role = var.create_rds_monitoring_role
  rds_monitoring_role_name   = var.rds_monitoring_role_name
  
  # RDS Backup Role
  create_rds_backup_role = var.create_rds_backup_role
  rds_backup_role_name   = var.rds_backup_role_name
  rds_backup_bucket_arns = var.rds_backup_bucket_arns
  
  tags = var.tags
}

# Managed AD
module "managed_ad" {
  source = "./managed_ad"

  vpc_id             = var.vpc_id
  domain_name        = var.domain_name
  short_name         = var.short_name
  admin_password     = var.admin_password
  private_subnet_ids = var.private_subnet_ids
  edition            = var.ad_edition
  enable_logs        = var.enable_ad_logs
  log_retention_days = var.ad_log_retention_days
  tags               = var.tags
}