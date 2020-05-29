# ! ============ VPC ============
resource "aws_vpc" "_vpc" {
  cidr_block = var.vpc_cidrs

  tags = {
    Name = "x_vpc"
  }
}

# ! ============ Internet Gateway - IGW ============
# Create IGW and attach it to the VPC
resource "aws_internet_gateway" "_igw" {
  vpc_id = aws_vpc._vpc.id

  tags = {
    Name = "x_igw"
  }
}

# ! ============ Route Tables - RT ============
resource "aws_route_table" "_public_rt" {
  vpc_id = aws_vpc._vpc.id

  route {
    cidr_block = "0.0.0.0/0"                  # Route everything throgh this table
    gateway_id = aws_internet_gateway._igw.id # attach to gateway for internet connectivity
  }

  tags = {
    Name = "x_public_rt"
  }
}

# private route table become as a main/default table, so whatever is not explicitly not configured will be associated
# with private table, like RDS subnets.
resource "aws_default_route_table" "my_private_rt" {
  default_route_table_id = aws_vpc._vpc.default_route_table_id

  tags = {
    Name = "x_private_rt"
  }
}

# ! ============ Subnets ============
# ! Public
resource "aws_subnet" "_public_subnets" {
  //  count = length(data.aws_availability_zones.available_zones.names) # will generate 6 public subnets in us-east-1
  count      = var.public_subnets_count
  vpc_id     = aws_vpc._vpc.id
  cidr_block = cidrsubnet(var.vpc_cidrs, 8, count.index)

  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}

# ! Private - EC2
resource "aws_subnet" "_private_subnets" {
  count      = var.private_subnets_count
  vpc_id     = aws_vpc._vpc.id
  cidr_block = cidrsubnet(var.vpc_cidrs, 8, count.index + 2)

  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}

# ! Private - RDS
resource "aws_subnet" "_private_rds_subnets" {
  count      = var.private_rds_subnets_count
  vpc_id     = aws_vpc._vpc.id
  cidr_block = cidrsubnet(var.vpc_cidrs, 8, count.index + 4)

  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateSubnet-RDS-${count.index + 1}"
  }
}

# ! ============ RDS Subnet Group ============
resource "aws_db_subnet_group" "_rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = aws_subnet._private_rds_subnets.*.id

  tags = {
    Name = "rds_subnet_group"
  }
}

# ! ============ Subnet Associations ============
resource "aws_route_table_association" "_public_association" {
  count          = var.public_subnets_count
  subnet_id      = aws_subnet._public_subnets[count.index].id
  route_table_id = aws_route_table._public_rt.id
}

resource "aws_route_table_association" "_private_association" {
  count          = var.private_subnets_count
  subnet_id      = aws_subnet._private_subnets[count.index].id
  route_table_id = aws_default_route_table.my_private_rt.id
}
