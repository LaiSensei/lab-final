resource "aws_lb" "connectus_lb" {
  name               = "connectus-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.connectus_sg.id]
  subnets            = [aws_subnet.connectus_subnet.id, aws_subnet.connectus_subnet_2.id]

  enable_deletion_protection = false
  idle_timeout = 60
}



resource "aws_lb_target_group" "connectus_target_group" {
  name     = "connectus-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.connectus_vpc.id
}

resource "aws_lb_listener" "connectus_lb_listener" {
  load_balancer_arn = aws_lb.connectus_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.connectus_target_group.arn
  }
}
