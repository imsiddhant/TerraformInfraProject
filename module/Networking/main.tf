# This is Project's Networking Module

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Module = "Networking"
      Name   = var.tag_value
    }
  }
}

resource "aws_vpc" "mainvpc" {
  cidr_block = "192.168.10.0/24"
}

resource "aws_subnet" "PrivateSubnet" {
  vpc_id                  = aws_vpc.mainvpc.id
  cidr_block              = "192.168.10.0/27"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  depends_on              = [aws_vpc.mainvpc]
}

resource "aws_subnet" "PublicSubnet1" {
  vpc_id                  = aws_vpc.mainvpc.id
  cidr_block              = "192.168.10.32/27"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  depends_on              = [aws_vpc.mainvpc]
}

resource "aws_subnet" "PublicSubnet2" {
  vpc_id                  = aws_vpc.mainvpc.id
  cidr_block              = "192.168.10.64/27"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  depends_on              = [aws_vpc.mainvpc]
}

resource "aws_internet_gateway" "IGW" {
  vpc_id     = aws_vpc.mainvpc.id
  depends_on = [aws_vpc.mainvpc]
}

resource "aws_route_table" "PrivateRT" {
  vpc_id     = aws_vpc.mainvpc.id
  depends_on = [aws_vpc.mainvpc]
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.mainvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  depends_on = [aws_internet_gateway.IGW]
}

resource "aws_route_table_association" "PriRT" {
  subnet_id      = aws_subnet.PrivateSubnet.id
  route_table_id = aws_route_table.PrivateRT.id
  depends_on     = [aws_route_table.PrivateRT]
}

resource "aws_route_table_association" "PubRT1" {
  subnet_id      = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.PublicRT.id
  depends_on     = [aws_route_table.PublicRT]
}

resource "aws_route_table_association" "PubRT2" {
  subnet_id      = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.PublicRT.id
  depends_on     = [aws_route_table.PublicRT]
}

resource "aws_security_group" "AllowPublic" {
  name       = "allow_http"
  vpc_id     = aws_vpc.mainvpc.id
  depends_on = [aws_vpc.mainvpc]
}

resource "aws_vpc_security_group_ingress_rule" "AllowPublicHTTP" {
  security_group_id = aws_security_group.AllowPublic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "80"
  depends_on        = [aws_security_group.AllowPublic]
}

resource "aws_vpc_security_group_egress_rule" "AllowAll" {
  security_group_id = aws_security_group.AllowPublic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  depends_on        = [aws_security_group.AllowPublic]
}

resource "aws_security_group" "FromALBOnly" {
  name       = "allow_from_alb"
  vpc_id     = aws_vpc.mainvpc.id
  depends_on = [aws_security_group.AllowPublic]
}

resource "aws_security_group_rule" "AllowFromLB" {
  type                     = "ingress"
  security_group_id        = aws_security_group.FromALBOnly.id
  source_security_group_id = aws_security_group.AllowPublic.id
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  depends_on               = [aws_security_group.FromALBOnly]
}

resource "aws_vpc_security_group_egress_rule" "AllowAllEC2" {
  security_group_id = aws_security_group.FromALBOnly.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  depends_on        = [aws_security_group.FromALBOnly]
}
