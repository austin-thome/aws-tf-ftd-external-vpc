################################################################################
# Subnets
################################################################################

resource "aws_subnet" "outside" {
  count = length(var.outside_subnets)
  cidr_block = element(var.outside_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.vpc.id
  availability_zone = element(var.azs, count.index)
  # customer_owned_ipv4_pool = element(var.customer_owned_ipv4_pool,count.index)
  # map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch
  # ipv6_cidr_block = element(var.ipv6_cidr_block,count.index)
  outpost_arn = var.outpost_arn
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation



  tags = {
    Name = "${var.name}-OUT-${count.index+1}"
  }
}

resource "aws_subnet" "inside" {
  count = length(var.inside_subnets)
  cidr_block = element(var.inside_subnets, count.index)
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
    Name = "${var.name}-IN-${count.index+1}"
  }
}

resource "aws_subnet" "mgmt" {
  count = length(var.mgmt_subnets)
  cidr_block = element(var.mgmt_subnets, count.index)
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
    Name = "${var.name}-MGMT-${count.index+1}"
  }
}