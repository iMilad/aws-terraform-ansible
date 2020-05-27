# ! ============ main.tf ============
aws_region  = "us-east-1"

# ! ============ vpc.tf ============
# VPC
vpc_cidrs = "10.40.0.0/16"

public_subnets_count      = 2
private_subnets_count     = 2
private_rds_subnets_count = 3

# ! ============ Security Group ============
dev_ips = ["46.75.184.136/32"]
