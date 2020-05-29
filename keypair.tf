# ! ============ Key Pair ============
# reade README.md for how to generate public key
resource "aws_key_pair" "_key_pair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)

  tags = {
    NAME = "ec2-${terraform.workspace}-KeyPair"
  }
}