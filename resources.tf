resource "aws_vpc" "env-example" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "terraform-aws-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = "${aws_vpc.env-example.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.env-example.cidr_block, 3, 1)}"
  availability_zone = "eu-west-2a"
}

resource "aws_subnet" "subnet2" {
  vpc_id            = "${aws_vpc.env-example.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.env-example.cidr_block, 2, 2)}"
  availability_zone = "eu-west-2b"
}

resource "aws_security_group" "subnet-security" {
  vpc_id = "${aws_vpc.env-example.id}"
  ingress {
    cidr_blocks = [
      "${aws_vpc.env-example.cidr_block}"
    ]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
}
