# This is Project's Compute Module (Includes EC2, ASG, and ALB)

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Module = "Compute"
      Name   = var.tag_value
    }
  }
}

module "Networking"{
  source = "../Networking"
}

data "aws_ami" "LatestAMI" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["a*-ami-202*-x86_64"]
  }
}

resource "aws_launch_template" "LT_main" {
  instance_type          = "t2.micro"
  image_id               = data.aws_ami.LatestAMI.image_id
  vpc_security_group_ids = [module.Networking.internal_sg_id]
}

resource "aws_autoscaling_group" "ProdASG" {
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [module.Networking.public_subnet_1, module.Networking.public_subnet_2]

  launch_template {
    id      = aws_launch_template.LT_main.id
    version = "$Latest"
  }

  depends_on = [aws_launch_template.LT_main]
}

resource "aws_lb" "ProdLB" {
  name               = "ProdLB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.Networking.external_sg_id]
  subnets            = [module.Networking.public_subnet_1, module.Networking.public_subnet_2]
  depends_on         = [aws_autoscaling_group.ProdASG]
}

resource "aws_lb_target_group" "ProdTG" {
  name     = "Prod-Target-80"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.Networking.main_vpc_id
}

resource "aws_lb_listener" "FrontEnd" {
  load_balancer_arn = aws_lb.ProdLB.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ProdTG.arn
  }
  depends_on = [aws_lb_target_group.ProdTG]
}

resource "aws_autoscaling_attachment" "ELB" {
  autoscaling_group_name = aws_autoscaling_group.ProdASG.id
  elb                    = aws_lb.ProdLB.id
  depends_on             = [aws_lb.ProdLB]
}

resource "aws_autoscaling_attachment" "TG" {
  autoscaling_group_name = aws_autoscaling_group.ProdASG.id
  lb_target_group_arn    = aws_lb_target_group.ProdTG.arn
  depends_on             = [aws_lb_target_group.ProdTG]
}
