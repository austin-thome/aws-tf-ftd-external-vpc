################################################################################
# Internet and NAT Gateways
################################################################################
# Deploys a single Internet GW, and a NAT GW for each private subnet.

resource "aws_internet_gateway" "int_gateway" {
  count = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.name
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count = var.create_igw && length(var.outside_subnets) > 0 ? length(var.outside_subnets) : 0
  # ? 1 : 0

  allocation_id = element(aws_eip.nat_eip.*.id,count.index)
  # connectivity_type = var.connectivity_type
  subnet_id = element(aws_subnet.outside.*.id,count.index)

  tags = {
    Name = "${var.name}-${count.index+1}"
  }
}

resource "aws_eip" "nat_eip" {
  count = var.create_igw && length(var.outside_subnets) > 0 ? length(var.outside_subnets) : 0

  # address = element(var.address,count.index)
  # associate_with_private_ip = element(var.associate_with_private_ip,count.index)
  # customer_owned_ipv4_pool = element(var.customer_owned_ipv4_pool,count.index)
  # instance = element(var.instance,count.index)
  # network_border_group = element(var.network_border_group,count.index)
  # network_interface = element(var.network_interface,count.index)
  # public_ipv4_pool = element(var.public_ipv4_pool,count.index)
  vpc = var.vpc

  tags = {
    Name = "${var.name}-${count.index+1}"
  }
}

################################################################################
# VPN Gateway
################################################################################

resource "aws_vpn_gateway" "vgw" {
  count = var.enable_vpn_gateway ? 1 : 0

  vpc_id            = aws_vpc.vpc.id
  amazon_side_asn   = var.amazon_side_asn
  availability_zone = var.vpn_gateway_az

  tags = {
    Name = var.name
  }
}

resource "aws_vpn_gateway_attachment" "vgw_attach" {
  count = var.vpn_gateway_id != "" ? 1 : 0

  vpc_id         = aws_vpc.vpc.id
  vpn_gateway_id = var.vpn_gateway_id
}

resource "aws_vpn_gateway_route_propagation" "outside" {
  count = var.propagate_outside_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? 1 : 0

  route_table_id = element(aws_route_table.outside.*.id, count.index)
  vpn_gateway_id = element(
    concat(
      aws_vpn_gateway.vgw.*.id,
      aws_vpn_gateway_attachment.vgw_attach.*.vpn_gateway_id,
    ),
    count.index,
  )
}

resource "aws_vpn_gateway_route_propagation" "inside" {
  count = var.propagate_inside_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? length(var.inside_subnets) : 0

  route_table_id = element(aws_route_table.inside.*.id, count.index)
  vpn_gateway_id = element(
    concat(
      aws_vpn_gateway.vgw.*.id,
      aws_vpn_gateway_attachment.vgw_attach.*.vpn_gateway_id,
    ),
    count.index,
  )
}

resource "aws_vpn_gateway_route_propagation" "mgmt" {
  count = var.propagate_mgmt_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? length(var.mgmt_subnets) : 0

  route_table_id = element(aws_route_table.mgmt.*.id, count.index)
  vpn_gateway_id = element(
    concat(
      aws_vpn_gateway.vgw.*.id,
      aws_vpn_gateway_attachment.vgw_attach.*.vpn_gateway_id,
    ),
    count.index,
  )
}

################################################################################
# Customer Gateways
################################################################################

resource "aws_customer_gateway" "cgw" {
  for_each = var.customer_gateways

  bgp_asn     = each.value["bgp_asn"]
  ip_address  = each.value["ip_address"]
  device_name = lookup(each.value, "device_name", null)
  type        = "ipsec.1"

  tags = {
    Name = var.name
  }
}