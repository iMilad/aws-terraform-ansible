# ! ============ Security Group ============
# Dev instance SG
resource "aws_security_group" "_dev_sg" {
  name        = "x_dev_sg"
  description = "Security Group rules for dev instance."
  vpc_id      = aws_vpc._vpc.id

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = var.dev_ips
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = var.dev_ips
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Public Elastic Load Balancer - ELB
resource "aws_security_group" "_public_sg" {
  name        = "x_public_sg"
  description = "give access to ELB to connect to internet."
  vpc_id      = aws_vpc._vpc.id

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private ec2 intances, communication inside VPC network
resource "aws_security_group" "_private_sg" {
  name        = "x_private_sg"
  description = "Communication for all resources in VPC."
  vpc_id      = aws_vpc._vpc.id

  # Access from VPC
  ingress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = [var.vpc_cidrs]
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Relational Database - RDS
resource "aws_security_group" "_rds_sg" {
  name        = "x_private_rds_sg"
  description = "Security Group rules for RDS instances."
  vpc_id      = aws_vpc._vpc.id

  # SQL access from public/private SGs
  ingress {
    from_port = 3306
    protocol  = "tcp"
    to_port   = 3306

    security_groups = [
      aws_security_group._dev_sg.id,
      aws_security_group._public_sg.id,
      aws_security_group._private_sg.id
    ]
  }
}
