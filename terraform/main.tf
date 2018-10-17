# Set provider to AWS and specify region
provider "aws" {
  region = "${var.aws_region}"
  version = "~> 1.40.0"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

# Create a VPC
resource "aws_vpc" "adlab" {
  cidr_block = "${var.cidr_block_default}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags {
    Name = "adlabvpc"
    ResourceGroup = "${var.tag_text_default}"
  }
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
    from_port = 0
    to_port = 0
  }
  ingress {
    protocol = 6
    rule_no = 3389
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 3389
    to_port = 3389
  }
  tags {
    ResourceGroup = "${var.tag_text_default}"
  }
}


# Create internet gateway and associate with the VPC
resource "aws_internet_gateway" "adlabgw" {
  vpc_id = "${aws_vpc.adlab.id}"
  tags {
    ResourceGroup = "${var.tag_text_default}"
  }
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
  tags {
    ResourceGroup = "${var.tag_text_default}"
  }
}

resource "aws_route" "publictointernet" {
  route_table_id = "${aws_route_table.publicsubnets.id}"
  gateway_id = "${aws_internet_gateway.adlabgw.id}"
  destination_cidr_block = "0.0.0.0/0"
}


# Security Groups
resource "aws_security_group" "adlab_securitygroup_ad" {
  name = "adlab_securitygroup_ad"
  description = "Security Rules for AD to work, applied to the VPC CIDR"
  vpc_id = "${aws_vpc.adlab.id}"

  ingress {
    protocol = "tcp"
    from_port = 53
    to_port = 53
    description = "DNS/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "udp"
    from_port = 53
    to_port = 53
    description = "DNS/UDP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 88
    to_port = 88
    description = "Kerberos/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "udp"
    from_port = 88
    to_port = 88
    description = "Kerberos/UDP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 123
    to_port = 123
    description = "Time/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "udp"
    from_port = 123
    to_port = 123
    description = "Time/UDP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 135
    to_port = 135
    description = "NETBIOS/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "udp"
    from_port = 137
    to_port = 137
    description = "NETBIOS/UDP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "udp"
    from_port = 138
    to_port = 138
    description = "NETBIOS/UDP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 139
    to_port = 139
    description = "NETBIOS/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 389
    to_port = 389
    description = "LDAP/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "udp"
    from_port = 389
    to_port = 389
    description = "LDAP/UDP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 445
    to_port = 445
    description = "SMB/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "udp"
    from_port = 445
    to_port = 445
    description = "SMB/UDP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 464
    to_port = 464
    description = "Kerberos/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "udp"
    from_port = 464
    to_port = 464
    description = "Kerberos/UDP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 636
    to_port = 636
    description = "LDAPS/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 1024
    to_port = 5000
    description = "Dynamic Ports/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "udp"
    from_port = 1024
    to_port = 5000
    description = "Dynamic Ports/UDP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 3268
    to_port = 3268
    description = "Global Catalog/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 3269
    to_port = 3269
    description = "Global Catalog/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 5722
    to_port = 5722
    description = "DFS-R/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 9389
    to_port = 9389
    description = "AD Web Services/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
  ingress {
    protocol = "tcp"
    from_port = 49152
    to_port = 65535
    description = "Dynamic Ports/TCP"
    cidr_blocks = ["${var.cidr_block_default}"]
  }
}

resource "aws_security_group" "adlab_securitygroup_rdp" {
  name = "adlab_securitygroup_rdp"
  description = "Security Rules for RDP to work, applied to the Public CIDRs only"
  vpc_id = "${aws_vpc.adlab.id}"

    ingress {
    protocol = "tcp"
    from_port = 3389
    to_port = 3389
    description = "RDP/TCP"
    cidr_blocks = ["${var.domain1_cidr_public}","${var.domain2_cidr_public}"]
  }
}
