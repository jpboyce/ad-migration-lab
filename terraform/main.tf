# Set provider to AWS and specify region
provider "aws" {
  region = "${var.aws_region}"
}

# Create a VPC
resource "aws_vpc" "adlab" {
  cidr_block = "${var.cidr_block_default}"
}
