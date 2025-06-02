resource "aws_db_subnet_group" "main" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
  
  tags = merge(
    var.tags,
    {
      Name = var.db_subnet_group_name
    }
  )
}

resource "aws_db_parameter_group" "main" {
  name   = var.parameter_group_name
  family = var.parameter_group_family
  
  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }
  
  # SQL Server log parameters - using CloudWatch log exports instead of parameters
  # These parameters are not needed as we're using enabled_cloudwatch_logs_exports
  # to control which logs are exported to CloudWatch
  
  tags = var.tags
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_option_group" "main" {
  name                 = var.option_group_name
  engine_name          = var.engine
  major_engine_version = var.major_engine_version
  
  dynamic "option" {
    for_each = var.db_options
    content {
      option_name = option.value.option_name
      
      dynamic "option_settings" {
        for_each = lookup(option.value, "option_settings", [])
        content {
          name  = option_settings.value.name
          value = option_settings.value.value
        }
      }
    }
  }
  
  tags = var.tags
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "rds_logs" {
  for_each          = toset(var.enabled_cloudwatch_logs_exports)
  name              = "/aws/rds/instance/${var.identifier}/${each.value}"
  retention_in_days = var.cloudwatch_logs_retention_days
  kms_key_id        = var.cloudwatch_logs_kms_key_id
  
  tags = merge(
    var.tags,
    {
      Name = "/aws/rds/instance/${var.identifier}/${each.value}"
    }
  )
}

resource "aws_db_instance" "main" {
  identifier             = var.identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  storage_type           = var.storage_type
  storage_encrypted      = var.storage_encrypted
  kms_key_id             = var.kms_key_id
  
  username               = var.username
  password               = var.password
  
  db_subnet_group_name   = aws_db_subnet_group.main.name
  parameter_group_name   = aws_db_parameter_group.main.name
  option_group_name      = aws_db_option_group.main.name
  vpc_security_group_ids = [var.security_group_id]
  
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  
  skip_final_snapshot     = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.identifier}-final-snapshot"
  
  deletion_protection     = var.deletion_protection
  
  # SQL Server specific settings
  license_model           = var.license_model
  domain                  = var.domain_id
  domain_iam_role_name    = var.domain_iam_role_name
  
  # Performance and monitoring settings
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  performance_insights_kms_key_id       = var.performance_insights_enabled ? var.performance_insights_kms_key_id : null
  
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_arn                   = var.monitoring_interval > 0 ? var.monitoring_role_arn : null
  
  # CloudWatch Logs exports
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  
  # S3 import configuration
  dynamic "s3_import" {
    for_each = var.enable_s3_import ? [1] : []
    content {
      source_engine         = lookup(var.s3_import_configuration, "source_engine", "sqlserver")
      source_engine_version = lookup(var.s3_import_configuration, "source_engine_version", var.major_engine_version)
      bucket_name           = lookup(var.s3_import_configuration, "bucket_name", null)
      bucket_prefix         = lookup(var.s3_import_configuration, "bucket_prefix", null)
      ingestion_role        = lookup(var.s3_import_configuration, "ingestion_role", null)
    }
  }
  
  # Enhanced features
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  apply_immediately                     = var.apply_immediately
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  
  tags = merge(
    var.tags,
    {
      Name = var.identifier
    }
  )
  
  depends_on = [
    aws_db_subnet_group.main,
    aws_db_parameter_group.main,
    aws_db_option_group.main,
    aws_cloudwatch_log_group.rds_logs
  ]
  
  lifecycle {
    ignore_changes = [
      password
    ]
  }
}