resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_instance_profile
  monitoring                  = var.enable_monitoring
  user_data                   = var.user_data
  user_data_replace_on_change = var.user_data_replace_on_change

  metadata_options {
    http_tokens                 = "required"  # Enabled IMDSv2
    http_endpoint               = "enabled"   # Enabled IMDSv2
    http_put_response_hop_limit = var.http_put_response_hop_limit
  }
  
  root_block_device {
    encrypted   = true
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    tags        = merge(var.tags, { Name = "${var.name}-root-volume" })
  }

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

resource "aws_eip" "bastion" {
  count    = var.create_eip ? 1 : 0
  instance = aws_instance.bastion.id
  domain   = "vpc"

  tags = merge(
    var.tags,
    {
      Name = var.eip_name != null ? var.eip_name : "${var.name}-eip"
    }
  )
}