# ---------------------------------------------------------------------------------------------------------------------
# NETWORKING MODULES
# ---------------------------------------------------------------------------------------------------------------------

module "networking" {
  source = "./modules/networking"

  # VPC Configuration
  vpc_cidr_block       = var.vpc_cidr_block
  vpc_name             = var.vpc_name
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  availability_zones   = var.availability_zones
  region               = var.region
  create_nat_gateway   = var.create_nat_gateway
  enable_flow_logs     = var.enable_flow_logs
  flow_log_retention_days = var.flow_log_retention_days

  # Security Groups
  ad_security_group_name     = var.ad_security_group_name
  fsx_security_group_name    = var.fsx_security_group_name
  ec2_security_group_name    = var.ec2_security_group_name
  route53_security_group_name = var.route53_security_group_name
  rds_security_group_name    = var.rds_security_group_name
  
  # Security Group Rules
  # vpc_cidr_block is already defined above, so we don't need to pass it again
  ldap_port      = var.ldap_port
  ldaps_port     = var.ldaps_port
  dns_port       = var.dns_port
  smb_port       = var.smb_port
  rdp_port       = var.rdp_port
  mssql_port     = var.mssql_port
  
  # Route53 Configuration
  domain_name         = var.domain_name
  route53_endpoint_name = var.route53_endpoint_name
  resolver_rule_name  = var.route53_resolver_rule_name
  
  # Important: Set create_resolver_rule to false in the networking module
  # We'll create the resolver rule separately after the Managed AD is created
  create_resolver_rule = false
  
  # VPC Endpoints
  create_s3_endpoint  = var.create_s3_endpoint
  create_rds_endpoint = var.create_rds_vpc_endpoint
  
  # Common
  tags = var.tags
}

# ---------------------------------------------------------------------------------------------------------------------
# IDENTITY MODULES
# ---------------------------------------------------------------------------------------------------------------------

module "identity" {
  source = "./modules/identity"
  
  # Managed AD Configuration
  vpc_id             = module.networking.vpc_id
  domain_name        = var.domain_name
  short_name         = var.short_name
  admin_password     = var.admin_password
  private_subnet_ids = module.networking.private_subnet_ids
  ad_edition         = var.ad_edition
  enable_ad_logs     = var.enable_ad_logs
  ad_log_retention_days = var.ad_log_retention_days
  
  # IAM Configuration
  ec2_role_name             = var.ec2_role_name
  ec2_instance_profile_name = var.ec2_instance_profile_name
  ec2_policy_arns           = var.policy_arns
  create_ec2_custom_policy  = var.create_custom_policy
  ec2_custom_policy_document = var.custom_policy_document
  
  # RDS IAM Roles
  create_rds_ad_auth_role   = true
  rds_ad_auth_role_name     = var.rds_ad_auth_role_name
  create_rds_monitoring_role = var.rds_enable_enhanced_monitoring
  rds_monitoring_role_name   = var.rds_monitoring_role_name
  create_rds_backup_role     = true
  rds_backup_role_name       = var.rds_backup_role_name
  # Break the circular dependency by using an empty list initially
  rds_backup_bucket_arns     = []
  
  # Common
  tags = var.tags
  
  # Add explicit dependency on networking
  depends_on = [module.networking]
}

# ---------------------------------------------------------------------------------------------------------------------
# ROUTE53 RESOLVER RULE MODULE
# ---------------------------------------------------------------------------------------------------------------------

module "route53_resolver_rule" {
  source = "./modules/route53_resolver_rule"
  
  create_resolver_rule = var.create_resolver_rule
  domain_name = var.domain_name
  resolver_rule_name = var.route53_resolver_rule_name
  vpc_id = module.networking.vpc_id
  resolver_endpoint_id = module.networking.route53_endpoint_id
  target_ip_addresses = [
    {
      ip = module.identity.managed_ad_dns_ip_addresses_list[0]
    },
    {
      ip = module.identity.managed_ad_dns_ip_addresses_list[1]
    }
  ]
  tags = var.tags
  
  depends_on = [
    module.networking,
    module.identity
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# STORAGE MODULES
# ---------------------------------------------------------------------------------------------------------------------

module "storage" {
  source = "./modules/storage"
  
  # Common
  vpc_id            = module.networking.vpc_id
  region            = var.region
  tags              = var.tags
  
  # S3 Configuration
  rds_backup_bucket_name     = var.rds_backup_bucket_name
  rds_backup_lifecycle_rules = var.rds_backup_lifecycle_rules
  rds_instance_identifiers   = [var.rds_identifier]
  
  # FSx Configuration
  fsx_name                     = var.fsx_name
  fsx_security_group_id        = module.networking.fsx_security_group_id
  fsx_managed_ad_id            = module.identity.managed_ad_id
  fsx_private_subnet_id        = module.networking.private_subnet_ids[0]
  fsx_storage_capacity         = var.fsx_storage_capacity
  fsx_deployment_type          = var.fsx_deployment_type
  fsx_throughput_capacity      = var.fsx_throughput_capacity
  fsx_storage_type             = var.fsx_storage_type
  fsx_backup_retention_days    = var.fsx_backup_retention_days
  fsx_copy_tags_to_backups     = var.fsx_copy_tags_to_backups
  fsx_daily_backup_time        = var.fsx_daily_backup_time
  
  # RDS Configuration
  rds_security_group_id      = module.networking.rds_security_group_id
  rds_subnet_ids             = module.networking.private_subnet_ids
  rds_identifier             = var.rds_identifier
  rds_db_subnet_group_name   = var.rds_subnet_group_name
  rds_parameter_group_name   = var.rds_parameter_group_name
  rds_option_group_name      = var.rds_option_group_name
  rds_engine                 = var.rds_engine
  rds_engine_version         = var.rds_engine_version
  rds_major_engine_version   = var.rds_major_engine_version
  rds_instance_class         = var.rds_instance_class
  rds_allocated_storage      = var.rds_allocated_storage
  rds_max_allocated_storage  = var.rds_max_allocated_storage
  rds_storage_type           = var.rds_storage_type
  rds_storage_encrypted      = var.rds_storage_encrypted
  rds_username               = var.rds_username
  rds_password               = var.rds_password
  rds_multi_az               = var.rds_multi_az
  rds_backup_retention_period = var.rds_backup_retention_period
  rds_backup_window          = var.rds_backup_window
  rds_maintenance_window     = var.rds_maintenance_window
  rds_skip_final_snapshot    = var.rds_skip_final_snapshot
  rds_deletion_protection    = var.rds_deletion_protection
  rds_license_model          = var.rds_license_model
  rds_domain_id              = module.identity.managed_ad_id
  rds_domain_iam_role_name   = module.identity.rds_ad_auth_role_name
  rds_monitoring_interval    = var.rds_monitoring_interval
  rds_monitoring_role_arn    = module.identity.rds_monitoring_role_arn
  rds_performance_insights_enabled = var.rds_enable_performance_insights
  rds_performance_insights_retention_period = var.rds_performance_insights_retention_period
  rds_enabled_cloudwatch_logs_exports = var.rds_enabled_cloudwatch_logs_exports
  rds_cloudwatch_logs_retention_days = var.rds_cloudwatch_logs_retention_days
  rds_enable_audit_log       = var.rds_enable_audit_log
  rds_enable_error_log       = var.rds_enable_error_log
  rds_enable_agent_log       = var.rds_enable_agent_log
  rds_enable_s3_import       = var.rds_enable_s3_import
  rds_s3_import_configuration = merge(
    var.rds_s3_import_configuration,
    {
      bucket_name    = var.rds_backup_bucket_name
      ingestion_role = module.identity.rds_backup_role_arn
    }
  )
  rds_auto_minor_version_upgrade = var.rds_auto_minor_version_upgrade
  rds_apply_immediately     = var.rds_apply_immediately
  rds_copy_tags_to_snapshot = var.rds_copy_tags_to_snapshot
  rds_parameters            = var.rds_parameters
  rds_options               = concat(
    var.rds_options,
    [
      {
        option_name = "SQLSERVER_BACKUP_RESTORE"
        option_settings = [
          {
            name  = "IAM_ROLE_ARN"
            value = module.identity.rds_backup_role_arn
          }
        ]
      }
    ]
  )
  
  depends_on = [
    module.identity,
    module.networking
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# COMPUTE MODULES
# ---------------------------------------------------------------------------------------------------------------------

module "compute" {
  source = "./modules/compute"
  
  # Common
  vpc_id = module.networking.vpc_id
  tags   = var.tags
  
  # EC2 Configuration
  ec2_instances = {
    for name, instance in var.instances : name => merge(instance, {
      subnet_id = name == "bastion" ? module.networking.public_subnet_ids[0] : module.networking.private_subnet_ids[0],
      vpc_security_group_id = module.networking.ec2_security_group_id,
      iam_instance_profile = module.identity.ec2_instance_profile_name
    }) if name != "bastion"
  }
  
  # Bastion Configuration
  bastion_enabled = contains(keys(var.instances), "bastion")
  bastion_config = contains(keys(var.instances), "bastion") ? {
    ami = var.instances["bastion"].ami
    instance_type = var.instances["bastion"].type
    subnet_id = module.networking.public_subnet_ids[0]
    security_group_id = module.networking.ec2_security_group_id
    key_name = var.instances["bastion"].key_name
    iam_instance_profile = module.identity.ec2_instance_profile_name
    root_volume_size = lookup(var.instances["bastion"], "root_volume_size", 30)
    root_volume_type = lookup(var.instances["bastion"], "root_volume_type", "gp3")
    create_eip = lookup(var.instances["bastion"], "create_eip", true)
    eip_name = lookup(var.instances["bastion"], "eip_name", "Bastion-EIP")
  } : {}
  
  depends_on = [
    module.identity,
    module.networking,
    module.storage
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# UPDATE IAM POLICY AFTER S3 BUCKET CREATION
# ---------------------------------------------------------------------------------------------------------------------

# This resource updates the IAM policy after the S3 bucket is created
resource "aws_iam_role_policy" "rds_backup_policy_update" {
  name   = "${var.rds_backup_role_name}-policy-update"
  role   = module.identity.rds_backup_role_id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        Effect   = "Allow",
        Resource = [module.storage.rds_backup_bucket_arn]
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListMultipartUploadParts",
          "s3:AbortMultipartUpload"
        ],
        Effect   = "Allow",
        Resource = ["${module.storage.rds_backup_bucket_arn}/*"]
      }
    ]
  })
  
  depends_on = [module.storage, module.identity]
}