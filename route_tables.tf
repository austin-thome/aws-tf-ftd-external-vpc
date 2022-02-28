################################################################################
# Public Route Table
################################################################################
# Deploys a single custom route table associated with each public subnet.
# Includes routes to Internet Gateway and local VPC.

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  # depends_on = [aws_internet_gateway.int_gateway]

  tags = {
    Name = "${var.name}-Public"
  }

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.int_gateway.id
  # }
}

resource "aws_route" "public_internet_gateway" {
  count = var.create_igw ? 1 : 0

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.int_gateway[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePublic" {
  count = length(var.public_subnets)
  subnet_id = element(aws_subnet.public.*.id,count.index)
  route_table_id = element(aws_route_table.public.*.id,count.index)
}

################################################################################
# Private Route Tables
################################################################################
# Deploys route tables associated with each private subnet.
# Each table includes a route to the NAT GW in the corresponding public subnet and a route to the local VPC.

resource "aws_route_table" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.vpc.id
  # depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.name}-Priv-${count.index+1}"
  }

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  # }
}

resource "aws_route" "nat_gateway_priv" {
  count = var.create_igw && length(var.private_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gateway[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePrivate" {
  count = length(var.private_subnets)
  subnet_id = element(aws_subnet.private.*.id,count.index)
  route_table_id = element(aws_route_table.private.*.id,count.index)
}

################################################################################
# Database Route Tables
################################################################################
# Each table includes a route to the NAT GW in the corresponding public subnet and a route to the local VPC.

resource "aws_route_table" "database" {
  count = length(var.database_subnets)
  vpc_id = aws_vpc.vpc.id
  # depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.name}-DB-${count.index+1}"
  }
}

resource "aws_route" "nat_gateway_db" {
  count = var.create_igw && length(var.database_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.database[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gateway[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "AssociationForRouteTableDB" {
  count = length(var.database_subnets)
  subnet_id = element(aws_subnet.database.*.id,count.index)
  route_table_id = element(aws_route_table.database.*.id,count.index)
}