variable "tag_text_default" {
  description = "Text to be used in tags applied to AWS resources"
  default = "ADLAB"
}

variable "aws_region" {
  description = "AWS Region to create items into"
  default = "us-west-2"
}

variable "cidr_block_default" {
  description = "Default CIDR block value"
  default = "10.0.0.0/16"
}

variable "aws_amis" {
  type = "map"
  description = "AWS AMI Mappings for OSes"
  default = {
    "windows2008sp2" = "ami-7d35d31f"
    "windows2008r2sp1" = "ami-29cd2a4b"
    "windows2012r2" = "ami-ed33d48f"
  }
}

# Instance Types
variable "instance_type_dc" {
  type = "list"
  description = "Allowed instance types for Domain Controllers"
  default = ["t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large"]
}
variable "instance_type_rdgw" {
  type = "list"
  description = "Allowed instance types for Remote Desktop Gateways"
  default = ["t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large", "t2.xlarge", "m4.large", "m4.xlarge"]
}
variable "instance_type_xch" {
  type = "list"
  description = "Allowed instance types for Exchange"
  default = ["t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large", "t2.xlarge", "m4.large", "m4.xlarge"]
}
variable "instance_type_admt" {
  type = "list"
  description = "Allowed instance types for the ADMT Server"
  default = ["t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large", "t2.xlarge", "m4.large", "m4.xlarge"]
}
variable "instance_type_client" {
  type = "list"
  description = "Allowed instance types for Test Clients"
  default = ["t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large", "t2.xlarge", "m4.large", "m4.xlarge"]
}
