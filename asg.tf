# ! ============ Launch Configuration ============
resource "aws_launch_configuration" "_asg_lc" {
  name_prefix = "x-"

  image_id      = aws_ami_from_instance.custom_ami.id
  instance_type = var.asg_lc_instance_type

  security_groups      = [aws_security_group._private_sg.id]
  iam_instance_profile = aws_iam_instance_profile.s3_access_profile.id

  key_name = aws_key_pair._key_pair.id

  lifecycle {
    create_before_destroy = true
  }
}

# ! ============ Autoscalling Group ============
resource "aws_autoscaling_group" "_asg" {
  name                      = "asg-${terraform.workspace}-${aws_launch_configuration._asg_lc.id}"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = var.asg_grace
  health_check_type         = var.asg_hc_type
  desired_capacity          = var.asg_cap
  force_delete              = true
  target_group_arns         = [aws_lb_target_group._alb_tg.arn]

  vpc_zone_identifier = aws_subnet._private_subnets.*.id

  launch_configuration = aws_launch_configuration._asg_lc.name

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "asg-${var.domain_name}-${terraform.workspace}"
  }

  lifecycle {
    create_before_destroy = true
  }
}