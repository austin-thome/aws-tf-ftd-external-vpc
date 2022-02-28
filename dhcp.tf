################################################################################
# DHCP Options
################################################################################
# Allows for custom DHCP settings within the VPC.
# Custom DHCP options can be left disabled in most cases.

resource "aws_vpc_dhcp_options" "dhcp_options" {
  count = var.enable_dhcp_options ? 1 : 0

  domain_name          = var.dhcp_options_domain_name
  domain_name_servers  = var.dhcp_options_domain_name_servers
  ntp_servers          = var.dhcp_options_ntp_servers
  netbios_name_servers = var.dhcp_options_netbios_name_servers
  netbios_node_type    = var.dhcp_options_netbios_node_type

  tags = {
      "Name" = var.name
    }
}

resource "aws_vpc_dhcp_options_association" "dhcp" {
  count = var.enable_dhcp_options ? 1 : 0

  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options[0].id
}