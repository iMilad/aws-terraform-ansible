# ! ============ main.tf ============
aws_region = "us-east-1"

# ! ============ Key Pair ============
key_name        = "ec2key"
public_key_path = "~/.ssh/ec2key.pub"

# ! ============ vpc.tf ============
vpc_cidrs = "10.20.0.0/16"
public_subnets_count      = 2
private_subnets_count     = 2
private_rds_subnets_count = 2

# ! ============ Security Group ============
dev_ips = ["46.75.184.136/32"]

# ! ============ S3 Code Repo ============
s3_bucket_force_destroy = true

# ! ============ Database - RDS ============
db_storage_gb       = 10
db_engine           = "postgres"
db_engine_version   = "11.6"
db_instance_class   = "db.t2.micro"
db_username         = "united83"
db_password         = "xpassword"
skip_final_snapshot = true

# ! ============ Application Load Balancer ============
alb_healthy_threshold   = 2
alb_unhealthy_threshold = 2
alb_interval            = 30
alb_timeout             = 5

# ! ============ Customized AMI ============
ami_base_id         = "ami-0323c3dd2da7fb37d"
ec2_base_instance_type = "t2.micro"
ec2_base_name = "base_ami"

# ! ============ ASG ============
asg_lc_instance_type = "t2.micro"
asg_min_size         = 1
asg_max_size         = 3
asg_grace            = 300
asg_hc_type          = "EC2"
asg_cap              = 2
