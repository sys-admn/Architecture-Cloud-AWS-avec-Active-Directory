output "resolver_rule_id" {
  description = "The ID of the Route53 Resolver rule"
  value       = var.create_resolver_rule ? aws_route53_resolver_rule.forward_rule[0].id : null
}

output "resolver_rule_arn" {
  description = "The ARN of the Route53 Resolver rule"
  value       = var.create_resolver_rule ? aws_route53_resolver_rule.forward_rule[0].arn : null
}

output "resolver_rule_association_id" {
  description = "The ID of the Route53 Resolver rule association"
  value       = var.create_resolver_rule ? aws_route53_resolver_rule_association.forward_rule_association[0].id : null
}