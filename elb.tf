# ! ============ Application Load Balancer ============
resource "aws_lb" "_alb" {
  name               = "${var.domain_name}-alb"
  load_balancer_type = "application"
  internal           = false

  security_groups = [aws_security_group._public_sg.id]

  subnets = aws_subnet._public_subnets.*.id

  idle_timeout = 400

  tags = {
    Name = "alb-${var.domain_name}"
  }
}

resource "aws_lb_listener" "_alb_listener" {
  load_balancer_arn = aws_lb._alb.arn
  port              = 80
  protocol          = "http"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group._alb_tg.arn
  }
}

resource "aws_lb_target_group" "_alb_tg" {
  name        = "alb-${var.domain_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc._vpc.id

  health_check {
    healthy_threshold   = var.alb_healthy_threshold
    interval            = var.alb_interval
    timeout             = var.alb_timeout
    unhealthy_threshold = var.alb_unhealthy_threshold
  }

  tags = {
    Name = "alb-tg-${var.domain_name}"
  }
}
