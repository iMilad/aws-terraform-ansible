# ! ============ RDS ============
# https://www.terraform.io/docs/providers/aws/r/db_instance.html
resource "aws_db_instance" "my_db" {
  allocated_storage      = var.db_storage_gb
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  name                   = "${terraform.workspace}-db"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group._rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group._rds_sg.id]
  skip_final_snapshot    = var.skip_final_snapshot
}