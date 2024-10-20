# This is Project's Monitoring Module (Includes Cloudwatch resources)

resource "aws_cloudwatch_metric_alarm" "EC2_CPU" {
  alarm_name = "EC2_CPU_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 300
  statistic = "Average"
  threshold = 75
  alarm_description = "This alarm monitors the EC2 CPU Utilization"
  datapoints_to_alarm = 2
}