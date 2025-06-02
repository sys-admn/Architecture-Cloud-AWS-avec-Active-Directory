resource "aws_route53_resolver_endpoint" "outbound" {
  name      = var.endpoint_name
  direction = "OUTBOUND"
  security_group_ids = [var.security_group_id]

  dynamic "ip_address" {
    for_each = var.private_subnet_ids
    content {
      subnet_id = ip_address.value
      ip        = lookup(var.ip_addresses, ip_address.key, null)
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.endpoint_name
    }
  )
}

# Removed aws_route53_resolver_rule and aws_route53_resolver_rule_association resources
# These are now handled by the separate route53_resolver_rule module
# This allows us to use the DNS IP addresses from the Managed AD without creating a circular dependency