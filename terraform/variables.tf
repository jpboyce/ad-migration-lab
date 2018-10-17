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
