# This is Project's Database Module (Includes RDS)

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Module = "Database"
      Name   = var.tag_value
    }
  }
}

resource "aws_security_group" "rds_sg" {
  name   = "allow_from_ec2"
  vpc_id = var.vpc_id_main
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2sg]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "maindatabase" {
  engine                 = "mysql"
  identifier             = "mainrdsinstance"
  allocated_storage      = 20
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  username               = "mainrdsuser"
  password               = "myrdspassword"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  db_subnet_group_name   = var.privatesub
  skip_final_snapshot    = false
  publicly_accessible    = false
}