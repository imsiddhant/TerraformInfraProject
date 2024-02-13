# This is Project's Networking Module

provider "aws" {
  region = var.region
  
  default_tags {
    tags = {
      Module = "Networking"
      Name = var.tag_value
    }
  }
}

resource "aws_vpc" "mainvpc" {
  cidr_block = "192.168.10.0/27"
}

resource "aws_subnet" "PrivateSubnet" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "192.168.10.0/27"
  availability_zone = "us-wast-1a"
  map_public_ip_on_launch = false
  depends_on = [ aws_vpc.mainvpc ]
}

resource "aws_subnet" "PublicSubnet" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "192.168.10.32/27"
  availability_zone = "us-wast-1b"
  map_public_ip_on_launch = true
  depends_on = [ aws_vpc.mainvpc ]
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.mainvpc.id
  depends_on = [ aws_vpc.mainvpc ]
}

resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.mainvpc.id
  depends_on = [ aws_vpc.mainvpc ]
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.mainvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  depends_on = [ aws_internet_gateway.IGW ]
}

resource "aws_route_table_association" "PriRT" {
  subnet_id = aws_subnet.PrivateSubnet.id
  route_table_id = aws_route_table.PrivateRT.id
  depends_on = [ aws_route_table.PrivateRT ]
}

resource "aws_route_table_association" "PubRT" {
  subnet_id = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.PublicRT.id
  depends_on = [ aws_route_table.PublicRT ]
}