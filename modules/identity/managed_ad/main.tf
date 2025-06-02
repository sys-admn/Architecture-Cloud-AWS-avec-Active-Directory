resource "aws_directory_service_directory" "main" {
  name       = var.domain_name
  password   = var.admin_password
  edition    = var.edition
  type       = "MicrosoftAD"
  short_name = var.short_name

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.private_subnet_ids
  }

  tags = merge(
    var.tags,
    {
      Name = var.domain_name
    }
  )
}

resource "aws_cloudwatch_log_group" "ad_logs" {
  count             = var.enable_logs ? 1 : 0
  name              = "/aws/directoryservice/${var.domain_name}"
  retention_in_days = var.log_retention_days
  
  tags = var.tags
}

# Add resource policy to allow Directory Service to write logs
resource "aws_cloudwatch_log_resource_policy" "ad_logs_policy" {
  count           = var.enable_logs ? 1 : 0
  policy_name     = "ad-logs-policy-${var.domain_name}"
  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ds.amazonaws.com"
        }
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.ad_logs[0].arn}:*"
      }
    ]
  })
}

# Create log subscription after the policy is in place
resource "aws_directory_service_log_subscription" "ad_logs" {
  count            = var.enable_logs ? 1 : 0
  directory_id     = aws_directory_service_directory.main.id
  log_group_name   = aws_cloudwatch_log_group.ad_logs[0].name
  
  depends_on = [aws_cloudwatch_log_resource_policy.ad_logs_policy]
}