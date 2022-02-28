provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../"
  # The resources for this file live two directories above, in the root directory.

  name = "ftd-internal"
  # The name will be used to identify all resources. For example, subnets will be tagged with the name
  # along with the type of subnet (public, private, or db).

  cidr = "10.0.0.0/20"
  # Identifies the cidr block for your VPC.
  # NOTE: 10.0.0.0/8 is reserved for EC2-Classic

  azs = ["us-east-1a", "us-east-1b"]
  inside_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
  outside_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
  mgmt_subnets = ["10.0.4.0/24", "10.0.5.0/24"]
  # If you want to utilize a highly-available architecture spread across AZs, you can include multiple AZs
  # and multiple subnets. For each AZ specified, include that many subnets. If you want a single failover AZ,
  # then specify 2 AZs and 2 subnets in each layer you want to use.
  # If you don't want to use a layer, don't specify any subnets - just leave it blank.

  # More subnet options are below. In most cases, these can be left at "false".
  instance_tenancy = "default"
  enable_dns_support = false
  enable_dnshostnames = false
  enable_classiclink = false
  enable_classiclink_dns_support = false
  assign_generated_ipv6_cidr_block = false
  map_public_ip_on_launch = false

  assign_ipv6_address_on_creation = false

  # In most cases, it will not be necessary to set your own DHCP options.
  # Recommended to leave at defaults unless you have a specific reason.
  enable_dhcp_options = false
  dhcp_options_domain_name = ""
  dhcp_options_domain_name_servers = [""]
  dhcp_options_ntp_servers = [""]
  dhcp_options_netbios_name_servers = [""]
  dhcp_options_netbios_node_type = ""

  # If set to "false", no internet gateway will be created.
  create_igw = false

  # If set to "true", a VPN gateway will be created. You can control propagation using
  # the options beneath.
  enable_vpn_gateway = true
  propagate_outside_route_tables_vgw = true
  propagate_inside_route_tables_vgw = true
  propagate_mgmt_route_tables_vgw = true

  # If enable_vpn_gateway was set to "true", then customer gateways will be created if you also
  # include gateway information below.
  customer_gateways = {
    IP1 = {
      bgp_asn    = 65112
      ip_address = "1.2.3.4"
    },
    IP2 = {
      bgp_asn    = 65112
      ip_address = "5.6.7.8"
    }
  }

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  # The following should be left at "true" unless you have specific reasons for  not using Flow Logs.
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60
}