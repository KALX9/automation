provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_vpc" "basic_vpc" {
  cidr_block       = "190.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "basic-vpc"
  }
}

resource "aws_subnet" "basic_vpc" {
  vpc_id     = "${aws_vpc.basic_vpc.id}"
  cidr_block = "190.0.1.0/24"

  tags = {
    Name = "basic-subnet"
  }
}
