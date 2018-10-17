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
