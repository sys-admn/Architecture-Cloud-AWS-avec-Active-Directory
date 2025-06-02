resource "aws_route53_resolver_rule" "forward_rule" {
  count       = var.create_resolver_rule ? 1 : 0
  name        = var.resolver_rule_name
  rule_type   = "FORWARD"
  domain_name = var.domain_name

  resolver_endpoint_id = var.resolver_endpoint_id

  dynamic "target_ip" {
    for_each = var.target_ip_addresses
    content {
      ip   = target_ip.value.ip
      port = lookup(target_ip.value, "port", 53)
    }
  }

  tags = var.tags
}

resource "aws_route53_resolver_rule_association" "forward_rule_association" {
  count           = var.create_resolver_rule ? 1 : 0
  resolver_rule_id = aws_route53_resolver_rule.forward_rule[0].id
  vpc_id           = var.vpc_id
}