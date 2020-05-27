# ! ============ main.tf ============
aws_region  = "us-east-1"

# ! ============ vpc.tf ============
# VPC
vpc_cidrs = "10.40.0.0/16"

public_subnets_count      = 2
private_subnets_count     = 2
private_rds_subnets_count = 2

# ! ============ Security Group ============
dev_ips = ["46.75.184.136/32"]

# ! ============ S3 Code Repo ============
s3_bucket_force_destroy = false

# ! ============ Database - RDS ============
db_storage_gb = 30
db_engine = "postgresql"
db_engine_version = "11.6-R1"
db_instance_class = "db.t2.small"
db_username = "united83"
db_password = "pass"
skip_final_snapshot = true
