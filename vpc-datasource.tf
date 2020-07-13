provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_vpc" "basic_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-new"
  }
}

resource "aws_subnet" "basic_vpc" {
  count             = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = "${element(data.aws_availability_zones.azs.names, count.index)}"
  vpc_id            = "${aws_vpc.basic_vpc.id}"
  cidr_block        = "${element(var.sub_cidr, count.index)}"

  tags = {
    Name = "subnet-${count.index + 1}"
  }
}
