output "instance_id" {
  description = "ID of the bastion instance"
  value       = aws_instance.bastion.id
}

output "private_ip" {
  description = "Private IP of the bastion instance"
  value       = aws_instance.bastion.private_ip
}

output "public_ip" {
  description = "Public IP of the bastion instance (if applicable)"
  value       = aws_instance.bastion.public_ip
}

output "eip_id" {
  description = "ID of the Elastic IP (if created)"
  value       = var.create_eip ? aws_eip.bastion[0].id : null
}

output "eip_public_ip" {
  description = "Public IP of the Elastic IP (if created)"
  value       = var.create_eip ? aws_eip.bastion[0].public_ip : null
}