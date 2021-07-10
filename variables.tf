variable name {
  description = "AWS Region"
  type        = string
}

variable aws_region {
  description = "AWS Region"
  type        = string
}

variable aws_profile_name {
  description   = "AWS Profile Name who will provision the vpc"
  type          = map(string)
}

variable azs {
  description = "Availability Zones"
  type        = list(string)
}

variable cidr {
  description = "VPC CIDR Size"
  type        = string
}

variable private_subnets {
  description = "Private Subnets CIDR Size"
  type        = list(string)
}

variable public_subnets {
  description = "Public Subnets CIDR Size"
  type        = list(string)
}

variable instance_tenancy {
  description = "Instance Tenancy"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be false to disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be false to disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_classiclink" {
  description = "Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic"
  type        = bool
  default     = null
}

variable "enable_classiclink_dns_support" {
  description = "Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic"
  type        = bool
  default     = null
}

variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block"
  type        = bool
  default     = false
}

variable tags {
  description = "Aditional tags"
  type        = map(string)
  default     = {}
}

variable vpc_tags {
  description = "Aditional VPC tags"
  type        = map(string)
  default     = {}
}

variable private_subnet_tags {
  description = "Aditional private subnets tags"
  type        = map(string)
  default     = {}
}

variable public_subnet_tags {
  description = "Aditional public subnets tags"
  type        = map(string)
  default     = {}
}

variable private_route_table_tags {
  description = "Aditional private route table tags"
  type        = map(string)
  default     = {}
}

variable public_route_table_tags {
  description = "Aditional public route table tags"
  type        = map(string)
  default     = {}
}

variable igw_tags {
  description = "Aditional internet gatewat tags"
  type        = map(string)
  default     = {}
}

variable ntg_tags {
  description = "Aditional nat gatewat tags"
  type        = map(string)
  default     = {}
}

variable eip_tags {
  description = "Aditional elastic ip tags"
  type        = map(string)
  default     = {}
}