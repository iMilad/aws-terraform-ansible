# ! ============ main.tf ============
variable "aws_region" {
  type = string
}

variable "aws_credentials_path" {
  description = "Path to aws credentials file"
  type        = string
  default     = "~/.aws/credentials"
}

variable "domain_name" {
  description = "unique name for the project"
  default     = "united83"
}

# ! ============ Key Pair ============
variable "key_name" {
  type = string
}
variable "public_key_path" {
  type = string
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

# ! ============ S3 Code Repo ============
variable "s3_bucket_force_destroy" {
}

# ! ============ Database - RDS ============
variable "db_storage_gb" {
  description = "Allocation storage for database."
  type        = number
}
variable "db_engine" {
  description = "type of database, ex. mySQL, PostgreSQL, ..."
  type        = string
}
variable "db_engine_version" {
  description = "Database version to install."
  type        = string
}
variable "db_instance_class" {
  description = "EC2 instance type for database."
  type        = string
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type = string
}
variable "skip_final_snapshot" {
  description = "if true, it does not create snapshot before termination."
  type        = bool
}

# ! ============ ELB ============
# Target Group
variable "alb_healthy_threshold" {
  type = number
}
variable "alb_interval" {
  type = number
}
variable "alb_timeout" {
  type = number
}
variable "alb_unhealthy_threshold" {
  type = number
}

# ! ============ ASG ============
variable "asg_lc_instance_type" {
  type = string
}
variable "asg_image_id" {
  type = string
}
variable "asg_max_size" {
  type = number
}
variable "asg_min_size" {
  type = number
}
variable "asg_grace" {
  type = number
}
variable "asg_hc_type" {
  type = string
}
variable "asg_cap" {
  type = number
}
