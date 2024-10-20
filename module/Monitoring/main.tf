# This is Project's Monitoring Module (Includes Cloudwatch resources)

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Module = "Monitoring"
      Name   = var.tag_value
    }
  }
}

resource "aws_sns_topic" "DefaultTopic" {
  name = "default-sns-topic"
}

resource "aws_sns_topic_subscription" "Email" {
  topic_arn = aws_sns_topic.DefaultTopic.arn
  protocol = "email"
  endpoint = "sgahtori2000@gmail.com"
}

resource "aws_cloudwatch_metric_alarm" "ASG_CPU" {
  alarm_name = "ASG_CPU_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = 80
  alarm_description = "This alarm triggers if EC2 CPU Utilization reaches 80%"
  datapoints_to_alarm = 2
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  actions_enabled = true
  alarm_actions = [aws_sns_topic.DefaultTopic.arn]
}

resource "aws_cloudwatch_metric_alarm" "RDS_Storage" {
  alarm_name = "RDS_LowStorage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = 2
  metric_name = "FreeStorageSpace"
  namespace = "AWS/RDS"
  period = 60
  statistic = "Average"
  threshold = 10000000000
  alarm_description = "This alarm triggers if FreeSpace in the RDS database is less than 10G"
  datapoints_to_alarm = 2
  dimensions = {
    DBInstanceIdentifier = var.db_identity
  }
  actions_enabled = true
  alarm_actions = [aws_sns_topic.DefaultTopic.arn]
}