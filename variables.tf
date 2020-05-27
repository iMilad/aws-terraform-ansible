# ! ============ main.tf ============
variable "aws_region" {
  type = string
}

variable "aws_credentials_path" {
  description = "Path to aws credentials file"
  type        = string
  default     = "~/.aws/credentials"
}

# ! ============ vpc.tf ============
# Get all available zones
data "aws_availability_zones" "available_zones" {}

variable "vpc_cidrs" {
  description = "IP range for the VPC"
  type        = string
}

variable "public_subnets_count" {
  description = "number of public subnets"
}

variable "private_subnets_count" {
  description = "number of private subnets"
}

variable "private_rds_subnets_count" {
  description = "number of private subnets for RDS instances"
}

# ! ============ security_group.tf ============
variable "dev_ips" {
  description = "IP address to give access for SSH."
  type        = list(string)
}
