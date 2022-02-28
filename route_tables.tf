################################################################################
# Inside Route Table
################################################################################
# Deploys a single custom route table associated with each outside subnet.
# Includes routes to Internet Gateway and local VPC.

resource "aws_route_table" "outside" {
  vpc_id = aws_vpc.vpc.id
  # depends_on = [aws_internet_gateway.int_gateway]

  tags = {
    Name = "${var.name}-OUT-RT"
  }

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.int_gateway.id
  # }
}

resource "aws_route" "public_internet_gateway" {
  count = var.create_igw ? 1 : 0

  route_table_id         = aws_route_table.outside.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.int_gateway[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePublic" {
  count = length(var.outside_subnets)
  subnet_id = element(aws_subnet.outside.*.id,count.index)
  route_table_id = element(aws_route_table.outside.*.id,count.index)
}

################################################################################
# Outside Route Tables
################################################################################
# Deploys route tables associated with each inside subnet.
# Each table includes a route to the NAT GW in the corresponding outside subnet and a route to the local VPC.

resource "aws_route_table" "inside" {
  count = length(var.inside_subnets)
  vpc_id = aws_vpc.vpc.id
  # depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.name}-IN-${count.index+1}"
  }

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  # }
}

resource "aws_route" "nat_gateway_priv" {
  count = var.create_igw && length(var.inside_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.inside[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gateway[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePrivate" {
  count = length(var.inside_subnets)
  subnet_id = element(aws_subnet.inside.*.id,count.index)
  route_table_id = element(aws_route_table.inside.*.id,count.index)
}

################################################################################
# MGMT Route Tables
################################################################################
# Each table includes a route to the NAT GW in the corresponding outside subnet and a route to the local VPC.

resource "aws_route_table" "mgmt" {
  count = length(var.mgmt_subnets)
  vpc_id = aws_vpc.vpc.id
  # depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.name}-MGMT-${count.index+1}"
  }
}

resource "aws_route" "nat_gateway_mgmt" {
  count = var.create_igw && length(var.mgmt_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.mgmt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gateway[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "AssociationForRouteTableDB" {
  count = length(var.mgmt_subnets)
  subnet_id = element(aws_subnet.mgmt.*.id,count.index)
  route_table_id = element(aws_route_table.mgmt.*.id,count.index)
}