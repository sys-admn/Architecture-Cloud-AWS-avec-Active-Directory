output "instance_ids" {
  description = "Map of instance names to their IDs"
  value = {
    for k, inst in aws_instance.ec2 : k => inst.id
  }
}

output "private_ips" {
  description = "Private IPs of the EC2 instances"
  value       = { for k, v in aws_instance.ec2 : k => v.private_ip }
}

output "public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = { for k, v in aws_instance.ec2 : k => v.public_ip }
}

output "public_dns" {
  description = "Public DNS names of the EC2 instances"
  value       = { for k, v in aws_instance.ec2 : k => v.public_dns }
}