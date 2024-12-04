resource "aws_cloudwatch_log_group" "connectus_log_group" {
  name = "connectus-log-group"
}

resource "aws_cloudwatch_metric_alarm" "connectus_alarm" {
  alarm_name                = "HighCPUUtilization"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 80

  dimensions = {
    LoadBalancerName = aws_lb.connectus_lb.id
  }

  alarm_description = "This alarm monitors high CPU usage for instances behind the load balancer."
  insufficient_data_actions = []
  alarm_actions            = []
}

