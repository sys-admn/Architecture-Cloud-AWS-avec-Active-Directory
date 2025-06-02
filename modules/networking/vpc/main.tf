resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = merge(
    var.tags,
    {
      Name = var.vpc_name
    }
  )
}

resource "aws_subnet" "public" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, count.index)
  
  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
      Type = "Public"
    }
  )
}

resource "aws_subnet" "private" {
  count             = var.private_subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index + var.public_subnet_count)
  availability_zone = element(var.availability_zones, count.index)
  
  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
      Type = "Private"
    }
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-igw"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  
  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-rt-public"
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway for private subnet internet access
resource "aws_eip" "nat" {
  count  = var.create_nat_gateway ? 1 : 0
  domain = "vpc"
  
  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-nat-eip"
    }
  )
}

resource "aws_nat_gateway" "main" {
  count         = var.create_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id
  
  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-nat-gateway"
    }
  )
  
  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  
  dynamic "route" {
    for_each = var.create_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[0].id
    }
  }
  
  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-rt-private"
    }
  )
}

resource "aws_route_table_association" "private" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# VPC Flow Logs
resource "aws_flow_log" "vpc_flow_log" {
  count                = var.enable_flow_logs ? 1 : 0
  log_destination      = aws_cloudwatch_log_group.flow_log_group[0].arn
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id
  iam_role_arn         = aws_iam_role.vpc_flow_log_role[0].arn
  
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "flow_log_group" {
  count             = var.enable_flow_logs ? 1 : 0
  name              = "/aws/vpc-flow-logs/${var.vpc_name}"
  retention_in_days = var.flow_log_retention_days
  
  tags = var.tags
}

resource "aws_iam_role" "vpc_flow_log_role" {
  count = var.enable_flow_logs ? 1 : 0
  name  = "${var.vpc_name}-vpc-flow-log-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
  
  tags = var.tags
}

resource "aws_iam_role_policy" "vpc_flow_log_policy" {
  count = var.enable_flow_logs ? 1 : 0
  name  = "${var.vpc_name}-vpc-flow-log-policy"
  role  = aws_iam_role.vpc_flow_log_role[0].id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}