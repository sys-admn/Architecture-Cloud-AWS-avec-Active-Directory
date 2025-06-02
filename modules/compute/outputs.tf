# EC2 Outputs
output "instance_ids" {
  description = "Map of EC2 instance names to their IDs"
  value       = module.ec2.instance_ids
}

output "private_ips" {
  description = "Map of EC2 instance names to their private IPs"
  value       = module.ec2.private_ips
}

output "public_ips" {
  description = "Map of EC2 instance names to their public IPs"
  value       = module.ec2.public_ips
}

# Bastion Outputs
output "bastion_instance_id" {
  description = "ID of the bastion instance"
  value       = var.bastion_enabled ? module.bastion[0].instance_id : null
}

output "bastion_private_ip" {
  description = "Private IP of the bastion instance"
  value       = var.bastion_enabled ? module.bastion[0].private_ip : null
}

output "bastion_public_ip" {
  description = "Public IP of the bastion instance"
  value       = var.bastion_enabled ? module.bastion[0].public_ip : null
}

output "bastion_eip_public_ip" {
  description = "Public IP of the bastion Elastic IP"
  value       = var.bastion_enabled && lookup(var.bastion_config, "create_eip", true) ? module.bastion[0].eip_public_ip : null
}