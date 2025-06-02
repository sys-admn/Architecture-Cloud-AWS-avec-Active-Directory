output "route53_endpoint_id" {
  description = "The ID of the Route 53 Resolver endpoint"
  value       = aws_route53_resolver_endpoint.outbound.id
}

output "route53_endpoint_arn" {
  description = "The ARN of the Route 53 Resolver endpoint"
  value       = aws_route53_resolver_endpoint.outbound.arn
}

output "route53_endpoint_ip_addresses" {
  description = "The IP addresses of the Route 53 Resolver endpoint"
  value       = [for ip in aws_route53_resolver_endpoint.outbound.ip_address : ip.ip]
}
