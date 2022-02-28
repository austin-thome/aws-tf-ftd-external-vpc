variable "name" {
  type = string
  description = ""
  default = ""
}

## VPC

variable "cidr" {
  type = string
  description = ""
  default = ""
}

variable "instance_tenancy" {
  type = string
  description = ""
  default = "default"
}

variable "enable_dns_support" {
  type = bool
  description = ""
  default = false
}

variable "enable_dnshostnames" {
  type = bool
  description = ""
  default = false
}

variable "enable_classiclink" {
  type = bool
  description = ""
  default = false
}

variable "enable_classiclink_dns_support" {
  type = bool
  description = ""
  default = false
}

variable "assign_generated_ipv6_cidr_block" {
  type = bool
  description = ""
  default = false
}

## SUBNETS

variable "inside_subnets" {
  type = list(string)
  description = ""
  default = []
}

variable "outside_subnets" {
  type = list(string)
  description = ""
  default = []
}

variable "mgmt_subnets" {
  type = list(string)
  description = ""
  default = []
}

## GATEWAYS

variable "map_public_ip_on_launch" {
  type = bool
  description = ""
  default = false
}

variable "azs" {
  type = list(string)
  description = ""
  default = []
}

variable "availability_zone_id" {
  type = list(string)
  description = ""
  default = []
}

variable "customer_owned_ipv4_pool" {
  type = list(string)
  description = ""
  default = []
}

variable "map_customer_owned_ip_on_launch" {
  type = bool
  description = ""
  default = false
}

variable "ipv6_cidr_block" {
  type = list(string)
  description = ""
  default = []
}

variable "outpost_arn" {
  type = string
  description = ""
  default = ""
}

variable "assign_ipv6_address_on_creation" {
  type = bool
  description = ""
  default = false
}

## GATEWAYS

variable "connectivity_type" {
  type = string
  description = ""
  default = ""
}

variable "address" {
  type = list(string)
  description = ""
  default = []
}

variable "associate_with_private_ip" {
  type = list(string)
  description = ""
  default = []
}

variable "instance" {
  type = list(string)
  description = ""
  default = []
}

variable "network_border_group" {
  type = list(string)
  description = ""
  default = []
}

variable "network_interface" {
  type = list(string)
  description = ""
  default = []
}

variable "public_ipv4_pool" {
  type = list(string)
  description = ""
  default = []
}

variable "vpc" {
  type = bool
  description = ""
  default = true
}

variable "create_igw" {
  type = bool
  description = ""
  default = true
}

## DHCP OPTIONS

variable "enable_dhcp_options" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  type        = bool
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

variable "dhcp_options_ntp_servers" {
  description = "Specify a list of NTP servers for DHCP options set (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = []
}

variable "dhcp_options_netbios_name_servers" {
  description = "Specify a list of netbios servers for DHCP options set (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = []
}

variable "dhcp_options_netbios_node_type" {
  description = "Specify netbios node_type for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = ""
}

## CUSTOMER GATEWAY

variable "customer_gateways" {
  description = "Maps of Customer Gateway's attributes (BGP ASN and Gateway's Internet-routable external IP address)"
  type        = map(map(any))
  default     = {}
}

## VPN GATEWAY

variable "enable_vpn_gateway" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
  type        = bool
  default     = false
}

variable "vpn_gateway_id" {
  description = "ID of VPN Gateway to attach to the VPC"
  type        = string
  default     = ""
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN."
  type        = string
  default     = "64512"
}

variable "vpn_gateway_az" {
  description = "The Availability Zone for the VPN Gateway"
  type        = string
  default     = null
}

variable "propagate_database_route_tables_vgw" {
  description = "Should be true if you want route table propagation"
  type        = bool
  default     = false
}

variable "propagate_private_route_tables_vgw" {
  description = "Should be true if you want route table propagation"
  type        = bool
  default     = false
}

variable "propagate_public_route_tables_vgw" {
  description = "Should be true if you want route table propagation"
  type        = bool
  default     = false
}

## FLOW LOGS

variable "enable_flow_log" {
  description = "Whether or not to enable VPC Flow Logs"
  type        = bool
  default     = false
}

variable "create_flow_log_cloudwatch_log_group" {
  description = "Whether to create CloudWatch log group for VPC Flow Logs"
  type        = bool
  default     = false
}

variable "create_flow_log_cloudwatch_iam_role" {
  description = "Whether to create IAM role for VPC Flow Logs"
  type        = bool
  default     = false
}

variable "flow_log_traffic_type" {
  description = "The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL."
  type        = string
  default     = "ALL"
}

variable "flow_log_destination_type" {
  description = "Type of flow log destination. Can be s3 or cloud-watch-logs."
  type        = string
  default     = "cloud-watch-logs"
}

variable "flow_log_log_format" {
  description = "The fields to include in the flow log record, in the order in which they should appear."
  type        = string
  default     = null
}

variable "flow_log_destination_arn" {
  description = "The ARN of the CloudWatch log group or S3 bucket where VPC Flow Logs will be pushed. If this ARN is a S3 bucket the appropriate permissions need to be set on that bucket's policy. When create_flow_log_cloudwatch_log_group is set to false this argument must be provided."
  type        = string
  default     = ""
}

variable "flow_log_cloudwatch_iam_role_arn" {
  description = "The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group. When flow_log_destination_arn is set to ARN of Cloudwatch Logs, this argument needs to be provided."
  type        = string
  default     = ""
}

variable "flow_log_cloudwatch_log_group_name_prefix" {
  description = "Specifies the name prefix of CloudWatch Log Group for VPC flow logs."
  type        = string
  default     = "/aws/vpc-flow-log/"
}

variable "flow_log_cloudwatch_log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group for VPC flow logs."
  type        = number
  default     = null
}

variable "flow_log_cloudwatch_log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data for VPC flow logs."
  type        = string
  default     = null
}

variable "flow_log_max_aggregation_interval" {
  description = "The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60` seconds or `600` seconds."
  type        = number
  default     = 600
}

variable "vpc_flow_log_tags" {
  description = "Additional tags for the VPC Flow Logs"
  type        = map(string)
  default     = {}
}

variable "vpc_flow_log_permissions_boundary" {
  description = "The ARN of the Permissions Boundary for the VPC Flow Log IAM Role"
  type        = string
  default     = null
}

