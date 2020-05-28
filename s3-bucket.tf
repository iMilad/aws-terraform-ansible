# ! ============ VPC Endpoint for S3 ============
# ! ============ Controlling access to services with VPC endpoints ============
resource "aws_vpc_endpoint" "_priavte_s3_endpoint" {
  service_name = "com.amazonaws.${var.aws_region}.s3"
  vpc_id       = aws_vpc._vpc.id

  # Local route—A default route for communication within the VPC.
  # Main route table—The route table that automatically comes with your VPC.
  route_table_ids = [
    aws_vpc._vpc.main_route_table_id,
    aws_route_table._public_rt.id
  ]

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
POLICY
}

# ! ============ S3 Code Bucket ============
# to be unique in name
resource "random_id" "s3_id" {
  byte_length = 2
}

resource "aws_s3_bucket" "_s3_bucket" {
  bucket = "${terraform.workspace}-${var.domain_name}-${random_id.s3_id.dec}"
  acl    = "private"
  //  force_destroy = terraform.workspace == "prod" ? false : true
  force_destroy = var.s3_bucket_force_destroy

  tags = {
    Name = "Code Reporitory"
  }
}
