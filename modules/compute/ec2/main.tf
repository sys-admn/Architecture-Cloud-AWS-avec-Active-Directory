resource "aws_instance" "ec2" {
  for_each = var.instances

  ami                         = each.value.ami
  instance_type               = each.value.type
  subnet_id                   = each.value.subnet_id
  associate_public_ip_address = each.value.associate_public_ip_address
  vpc_security_group_ids      = [each.value.vpc_security_group_id]
  key_name                    = each.value.key_name
  iam_instance_profile        = each.value.iam_instance_profile
  monitoring                  = var.enable_monitoring
  ebs_optimized               = var.enable_ebs_optimization
  user_data                   = lookup(each.value, "user_data", null)
  user_data_replace_on_change = lookup(each.value, "user_data_replace_on_change", false)

  metadata_options {
    http_tokens                 = "required"  # Enabled IMDSv2
    http_endpoint               = "enabled"   # Enabled IMDSv2
    http_put_response_hop_limit = var.http_put_response_hop_limit
  }
  
  root_block_device {
    encrypted   = true
    volume_size = lookup(each.value, "root_volume_size", 8)
    volume_type = lookup(each.value, "root_volume_type", "gp3")
    tags        = merge(var.tags, { Name = "${each.key}-root-volume" })
  }

  dynamic "ebs_block_device" {
    for_each = lookup(each.value, "ebs_block_devices", [])
    content {
      device_name           = ebs_block_device.value.device_name
      volume_size           = ebs_block_device.value.volume_size
      volume_type           = lookup(ebs_block_device.value, "volume_type", "gp3")
      encrypted             = lookup(ebs_block_device.value, "encrypted", true)
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", true)
      tags                  = merge(var.tags, { Name = "${each.key}-${ebs_block_device.value.device_name}" })
    }
  }

  tags = merge(
    var.tags,
    {
      Name = each.key
    },
    each.value.tags
  )
}