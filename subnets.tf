################################################################################
# Subnets
################################################################################

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  cidr_block = element(var.public_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.vpc.id
  availability_zone = element(var.azs, count.index)
  # customer_owned_ipv4_pool = element(var.customer_owned_ipv4_pool,count.index)
  # map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch
  # ipv6_cidr_block = element(var.ipv6_cidr_block,count.index)
  outpost_arn = var.outpost_arn
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation



  tags = {
    Name = "${var.name}-pub-${count.index+1}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  cidr_block = element(var.private_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.vpc.id
  availability_zone = element(var.azs, count.index)
  # availability_zone_id = var.availability_zone_id
  # customer_owned_ipv4_pool = element(var.customer_owned_ipv4_pool,count.index)
  # map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch
  # ipv6_cidr_block = element(var.ipv6_cidr_block,count.index)
  outpost_arn = var.outpost_arn
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  tags = {
    Name = "${var.name}-priv-${count.index+1}"
  }
}

resource "aws_subnet" "database" {
  count = length(var.database_subnets)
  cidr_block = element(var.database_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.vpc.id
  availability_zone = element(var.azs, count.index)
  # availability_zone_id = var.availability_zone_id
  # customer_owned_ipv4_pool = element(var.customer_owned_ipv4_pool,count.index)
  # map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch
  # ipv6_cidr_block = element(var.ipv6_cidr_block,count.index)
  outpost_arn = var.outpost_arn
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  tags = {
    Name = "${var.name}-db-${count.index+1}"
  }
}