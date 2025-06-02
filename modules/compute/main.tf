# EC2 Instances
module "ec2" {
  source = "./ec2"

  vpc_id = var.vpc_id
  instances = var.ec2_instances
  tags = var.tags
  
  enable_monitoring = var.enable_monitoring
  enable_ebs_optimization = var.enable_ebs_optimization
  http_put_response_hop_limit = var.http_put_response_hop_limit
}

# Bastion Host
module "bastion" {
  source = "./bastion"
  count  = var.bastion_enabled ? 1 : 0
  
  name = lookup(var.bastion_config, "name", "bastion")
  ami = var.bastion_config.ami
  instance_type = var.bastion_config.instance_type
  subnet_id = var.bastion_config.subnet_id
  security_group_id = var.bastion_config.security_group_id
  key_name = var.bastion_config.key_name
  iam_instance_profile = var.bastion_config.iam_instance_profile
  
  root_volume_size = lookup(var.bastion_config, "root_volume_size", 30)
  root_volume_type = lookup(var.bastion_config, "root_volume_type", "gp3")
  
  create_eip = lookup(var.bastion_config, "create_eip", true)
  eip_name = lookup(var.bastion_config, "eip_name", "Bastion-EIP")
  
  enable_monitoring = var.enable_monitoring
  http_put_response_hop_limit = var.http_put_response_hop_limit
  
  tags = var.tags
}