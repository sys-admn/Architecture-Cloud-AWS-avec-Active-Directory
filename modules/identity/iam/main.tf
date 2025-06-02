# EC2 Instance Role
resource "aws_iam_role" "ec2" {
  name = var.ec2_role_name
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  
  tags = var.tags
}

resource "aws_iam_instance_profile" "ec2" {
  name = var.ec2_instance_profile_name
  role = aws_iam_role.ec2.name
  
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ec2" {
  count      = length(var.ec2_policy_arns)
  role       = aws_iam_role.ec2.name
  policy_arn = var.ec2_policy_arns[count.index]
}

resource "aws_iam_role_policy" "ec2_custom" {
  count  = var.create_ec2_custom_policy ? 1 : 0
  name   = "${var.ec2_role_name}-custom-policy"
  role   = aws_iam_role.ec2.id
  policy = var.ec2_custom_policy_document
}

# RDS Directory Service Integration Role
resource "aws_iam_role" "rds_ad_auth" {
  count = var.create_rds_ad_auth_role ? 1 : 0
  name  = var.rds_ad_auth_role_name
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        }
      }
    ]
  })
  
  tags = var.tags
}

resource "aws_iam_role_policy" "rds_ad_auth_policy" {
  count = var.create_rds_ad_auth_role ? 1 : 0
  name  = "${var.rds_ad_auth_role_name}-policy"
  role  = aws_iam_role.rds_ad_auth[0].id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ds:DescribeDirectories",
          "ds:AuthorizeApplication",
          "ds:UnauthorizeApplication",
          "ds:GetAuthorizedApplicationDetails"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# RDS Monitoring Role
resource "aws_iam_role" "rds_monitoring" {
  count = var.create_rds_monitoring_role ? 1 : 0
  name  = var.rds_monitoring_role_name
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
  
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  count      = var.create_rds_monitoring_role ? 1 : 0
  role       = aws_iam_role.rds_monitoring[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# RDS Backup Role
resource "aws_iam_role" "rds_backup" {
  count = var.create_rds_backup_role ? 1 : 0
  name  = var.rds_backup_role_name
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        }
      }
    ]
  })
  
  tags = var.tags
}

resource "aws_iam_role_policy" "rds_backup_policy" {
  count = var.create_rds_backup_role ? 1 : 0
  name  = "${var.rds_backup_role_name}-policy"
  role  = aws_iam_role.rds_backup[0].id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        Effect   = "Allow",
        Resource = length(var.rds_backup_bucket_arns) > 0 ? var.rds_backup_bucket_arns : ["*"]
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListMultipartUploadParts",
          "s3:AbortMultipartUpload"
        ],
        Effect   = "Allow",
        Resource = length(var.rds_backup_bucket_arns) > 0 ? [for arn in var.rds_backup_bucket_arns : "${arn}/*"] : ["*"]
      }
    ]
  })
}