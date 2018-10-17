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


# Create internet gateway and associate with the VPC
resource "aws_internet_gateway" "adlabgw" {
  vpc_id = "${aws_vpc.adlab.id}"
}


# Subnets
# Domain1 Public Subnet
resource "aws_subnet" "domain1_subnet_public" {
  vpc_id = "${aws_vpc.adlab.id}"
  cidr_block = "${var.domain1_cidr_public}"
  tags {
    ResourceGroup = "${var.tag_text_default}"
  }
}
# Domain1 Private Subnet
resource "aws_subnet" "domain1_subnet_private" {
  vpc_id = "${aws_vpc.adlab.id}"
  cidr_block = "${var.domain1_cidr_private}"
  tags {
    ResourceGroup = "${var.tag_text_default}"
  }
}

# Domain2 Public Subnet
resource "aws_subnet" "domain2_subnet_public" {
  vpc_id = "${aws_vpc.adlab.id}"
  cidr_block = "${var.domain2_cidr_public}"
  tags {
    ResourceGroup = "${var.tag_text_default}"
  }
}
# Domain2 Private Subnet
resource "aws_subnet" "domain2_subnet_private" {
  vpc_id = "${aws_vpc.adlab.id}"
  cidr_block = "${var.domain2_cidr_private}"
  tags {
    ResourceGroup = "${var.tag_text_default}"
  }
}



# Route Tables for the Public Subnets to get to the internet
resource "aws_route_table" "publicsubnets" {
  vpc_id = "${aws_vpc.adlab.id}"
  route {
    cidr_block = "${var.domain1_cidr_public}"
    gateway_id = "${aws_internet_gateway.adlabgw.id}"
  }
  route {
    cidr_block = "${var.domain2_cidr_public}"
    gateway_id = "${aws_internet_gateway.adlabgw.id}"
  }
}
