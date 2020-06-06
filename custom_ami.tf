resource "aws_instance" "base" {
  ami = var.ami_base_id
  instance_type = var.ec2_base_instance_type

  key_name               = aws_key_pair._key_pair.id
  vpc_security_group_ids = [aws_security_group._dev_sg.id]
  subnet_id              = aws_subnet._public_subnets[0].id

  tags = {
    Name = var.ec2_base_name
  }

  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > ./config/ec2_hosts
[${var.ec2_base_name}]
${aws_instance.base.public_ip}
EOF
EOD
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.base.id} && ansible-playbook -i ./ec2_configuration/ec2_hosts ./ec2_configuration/dev.yml"
  }
}

resource "aws_ami_from_instance" "custom_ami" {
  name = "asg-${terraform.workspace}"
  source_instance_id = aws_instance.base.id
}