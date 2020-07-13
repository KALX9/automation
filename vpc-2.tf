resource "aws_vpc" "vpc_naveen" {
  cidr_block = "198.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags = {
    Name = "naveen-vpc"
  }
}

resource "aws_subnet" "public-subnet"  {
  availability_zone = "ap-southeast-1a"
  cidr_block = "198.0.1.0/24"
  map_public_ip_on_launch = "true"
  vpc_id = aws_vpc.vpc_naveen.id
  tags = {
    Name = "naveen-subnet-pub"
  }
}

resource "aws_subnet" "private-subnet"  {
  availability_zone = "ap-southeast-1b"
  cidr_block = "198.0.2.0/24"
  map_public_ip_on_launch = "false"
  vpc_id = aws_vpc.vpc_naveen.id
  tags = {
    Name = "naveen-subnet-prv"
  }
}



resource  "aws_internet_gateway" "naveen-igw" {
  vpc_id = aws_vpc.vpc_naveen.id
  tags = {
    Name = "naveen-igw"
  }
}

resource "aws_route_table" "naveen-route" {
  vpc_id = aws_vpc.vpc_naveen.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.naveen-igw.id
  }
  tags = {
    Name = "naveen-route"
  }
}
resource "aws_route_table_association" "naveen-asson" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.naveen-route.id
}
