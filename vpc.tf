resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags = {
    name = "naveen"
  }
}

resource "aws_subnet" "subnet_public-01" {
  availability_zone = "ap-southeast-1a"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    name = "subnet_public-01"
  }
}

resource "aws_subnet" "subnet_private-01" {
  availability_zone = "ap-southeast-1b"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    name = "subnet_private-01"
  }
}

resource "aws_internet_gateway" "igw-new" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    name = "igw-new"
  }
}
resource "aws_route_table" "route-1" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-new.id
  }
}

resource "aws_route_table_association" "routetosubnet" {
  subnet_id = aws_subnet.subnet_public-01.id
  route_table_id = aws_route_table.route-1.id

}
