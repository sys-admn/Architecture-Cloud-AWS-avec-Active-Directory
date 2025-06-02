resource "aws_s3_bucket" "main" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  
  tags = merge(
    var.tags,
    {
      Name = var.bucket_name
    }
  )
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_key_id != null ? "aws:kms" : "AES256"
      kms_master_key_id = var.kms_key_id
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "main" {
  count  = length(var.lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.main.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.status

      # Add filter block with prefix if provided, otherwise use empty filter
      filter {
        prefix = lookup(rule.value, "prefix", "")
      }

      dynamic "transition" {
        for_each = lookup(rule.value, "transitions", [])
        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "expiration" {
        for_each = lookup(rule.value, "expiration_days", null) != null ? [rule.value.expiration_days] : []
        content {
          days = expiration.value
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lookup(rule.value, "noncurrent_version_transitions", [])
        content {
          noncurrent_days = noncurrent_version_transition.value.days
          storage_class   = noncurrent_version_transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lookup(rule.value, "noncurrent_version_expiration_days", null) != null ? [rule.value.noncurrent_version_expiration_days] : []
        content {
          noncurrent_days = noncurrent_version_expiration.value
        }
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "main" {
  count  = var.bucket_policy != null ? 1 : 0
  bucket = aws_s3_bucket.main.id
  policy = var.bucket_policy
}

# Create a folder structure for RDS backups if specified
resource "aws_s3_object" "rds_backup_folder" {
  count  = var.create_rds_backup_folders ? 1 : 0
  bucket = aws_s3_bucket.main.id
  key    = "rds-backups/"
  content = ""  # Empty object
}

resource "aws_s3_object" "rds_instance_folders" {
  for_each = var.create_rds_backup_folders ? toset(var.rds_instance_identifiers) : []
  bucket   = aws_s3_bucket.main.id
  key      = "rds-backups/${each.value}/"
  content  = ""  # Empty object
}

# Create folders for different backup types
resource "aws_s3_object" "rds_backup_type_folders" {
  for_each = {
    for pair in var.create_rds_backup_folders ? 
      flatten([
        for instance in var.rds_instance_identifiers : [
          for type in ["full", "differential", "transaction-log"] : {
            instance = instance
            type     = type
          }
        ]
      ]) : [] :
      "${pair.instance}-${pair.type}" => pair
  }
  
  bucket  = aws_s3_bucket.main.id
  key     = "rds-backups/${each.value.instance}/${each.value.type}/"
  content = ""  # Empty object
}