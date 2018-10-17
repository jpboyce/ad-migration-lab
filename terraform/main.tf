# Set provider to AWS and specify region
provider "aws" {
  region = "${var.aws_region}"
}

# Create a VPC
resource "aws_vpc" "adlab" {
  cidr_block = "${var.cidr_block_default}"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create the default network ACL, allow ping from the internet and incoming RDP
resource "aws_default_network_acl" "default" {
  default_network_acl_id = "${aws_vpc.adlab.default_network_acl_id}"

  ingress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    icmp_code = "-1"
    icmp_type = "-1"
  }

  ingress {
    protocol = 6
    rule_no = 3389
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 3389
    to_port = 3389
  }
}


# Create internet gateway
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.adlab.id}"
}

# Create a subnet
resource "aws_subnet" "default_subnet" {
  vpc_id = "${aws_vpc.adlab.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}
