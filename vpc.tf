
################################################################################
# VPC
################################################################################

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr
  #instance_tenancy = var.instance_tenancy
  #enable_dns_support = var.enable_dns_support
  #enable_dns_hostnames = var.enable_dnshostnames
  #enable_classiclink = var.enable_classiclink
  #enable_classiclink_dns_support = var.enable_classiclink_dns_support
  #assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

  tags = {
    Name = var.name
  }
}