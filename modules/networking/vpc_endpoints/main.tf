resource "aws_vpc_endpoint" "rds" {
  count             = var.create_rds_endpoint ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.rds"
  vpc_endpoint_type = "Interface"
  
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.security_group_id]
  private_dns_enabled = true
  
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-rds-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "s3" {
  count        = var.create_s3_endpoint ? 1 : 0
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"
  
  # Directly specify route tables here instead of using separate association resources
  route_table_ids = compact([
    var.private_route_table_id,
    var.public_route_table_id
  ])
  
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-s3-endpoint"
    }
  )
}

# Removed the problematic route table associations:
# aws_vpc_endpoint_route_table_association.s3_private
# aws_vpc_endpoint_route_table_association.s3_public