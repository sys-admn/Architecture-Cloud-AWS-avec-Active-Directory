# VPC
module "vpc" {
  source = "./vpc"

  vpc_cidr_block       = var.vpc_cidr_block
  vpc_name             = var.vpc_name
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  availability_zones   = var.availability_zones
  region               = var.region
  create_nat_gateway   = var.create_nat_gateway
  enable_flow_logs     = var.enable_flow_logs
  flow_log_retention_days = var.flow_log_retention_days
  tags                 = var.tags
}

# VPC Endpoints
module "vpc_endpoints" {
  source = "./vpc_endpoints"

  vpc_id              = module.vpc.vpc_id
  region              = var.region
  name_prefix         = var.vpc_name
  create_s3_endpoint  = var.create_s3_endpoint
  create_rds_endpoint = var.create_rds_endpoint
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_id   = module.rds_security_group.security_group_id
  private_route_table_id = module.vpc.private_route_table_id
  public_route_table_id  = module.vpc.public_route_table_id
  tags                = var.tags
}

# Security Groups
module "ad_security_group" {
  source = "./security"

  name        = var.ad_security_group_name
  description = "Security group for Active Directory"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.ldap_port
      to_port     = var.ldap_port
      protocol    = "tcp"
      description = "LDAP"
    },
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.ldaps_port
      to_port     = var.ldaps_port
      protocol    = "tcp"
      description = "LDAPS"
    },
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.dns_port
      to_port     = var.dns_port
      protocol    = "tcp"
      description = "DNS TCP"
    },
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.dns_port
      to_port     = var.dns_port
      protocol    = "udp"
      description = "DNS UDP"
    },
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.smb_port
      to_port     = var.smb_port
      protocol    = "tcp"
      description = "SMB"
    }
  ]

  tags = var.tags
}

module "fsx_security_group" {
  source = "./security"

  name        = var.fsx_security_group_name
  description = "Security group for FSx"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.smb_port
      to_port     = var.smb_port
      protocol    = "tcp"
      description = "SMB"
    },
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.dns_port
      to_port     = var.dns_port
      protocol    = "tcp"
      description = "DNS TCP"
    },
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.dns_port
      to_port     = var.dns_port
      protocol    = "udp"
      description = "DNS UDP"
    }
  ]

  tags = var.tags
}

module "ec2_security_group" {
  source = "./security"

  name        = var.ec2_security_group_name
  description = "Security group for EC2 instances"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = var.rdp_port
      to_port     = var.rdp_port
      protocol    = "tcp"
      description = "RDP"
    },
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.smb_port
      to_port     = var.smb_port
      protocol    = "tcp"
      description = "SMB"
    },
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      description = "ICMP"
    }
  ]

  tags = var.tags
}

module "route53_security_group" {
  source = "./security"

  name        = var.route53_security_group_name
  description = "Security group for Route53 Resolver"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.dns_port
      to_port     = var.dns_port
      protocol    = "tcp"
      description = "DNS TCP"
    },
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.dns_port
      to_port     = var.dns_port
      protocol    = "udp"
      description = "DNS UDP"
    }
  ]

  tags = var.tags
}

module "rds_security_group" {
  source = "./security"

  name        = var.rds_security_group_name
  description = "Security group for RDS SQL Server"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      cidr_blocks = [var.vpc_cidr_block]
      from_port   = var.mssql_port
      to_port     = var.mssql_port
      protocol    = "tcp"
      description = "MS SQL"
    }
  ]

  tags = var.tags
}

# Route53 Resolver
module "route53" {
  source = "./route53"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = slice(module.vpc.private_subnet_ids, 0, 2)
  domain_name        = var.domain_name
  security_group_id  = module.route53_security_group.security_group_id
  endpoint_name      = var.route53_endpoint_name
  resolver_rule_name = var.resolver_rule_name
  create_resolver_rule = var.create_resolver_rule
  target_ip_addresses = var.dns_ip_addresses
  tags               = var.tags
}