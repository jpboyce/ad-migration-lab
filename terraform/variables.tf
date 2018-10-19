variable "tag_text_default" {
  description = "Text to be used in tags applied to AWS resources"
  default = "ADLAB"
}
variable "aws_region" {
  description = "AWS Region to create items into"
  default = "us-west-1"
}
variable "cidr_block_default" {
  description = "Default CIDR block value"
  default = "10.0.0.0/16"
}
variable "aws_amis" {
  type = "map"
  description = "AWS AMI Mappings for OSes"
  default = {
    "windows2008sp2" = "ami-01cbfcbf037d2e298"
    "windows2008r2sp1" = "ami-0cd391ee2ad7d80b0"
    "windows2012r2" = "ami-04370c2a300903acc"
  }
}

variable "aws_access_key" {
}
variable "aws_secret_key" {
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

# Domain 1 Details
variable "domain1_dnsname" {
  description = "FQDN of the first forest root domain"
  default = "contoso.com"
}
variable "domain1_netbiosname" {
  description = "NetBIOS name of the first domain (upto 15 characters)"
  default = "CONTOSO"
}
variable "domain1_cidr_private" {
  description = "CIDR of the private subnet used by the first domain"
  default = "10.0.11.0/24"
}
variable "domain1_ip_private_dc" {
  description = "Fixed private IP for the first Active Directory server"
  default = "10.0.11.10"
}
variable "domain1_name_dc" {
  description = "Name for the Domain 1 DC"
  default = "dc01"
}
variable "domain1_ip_private_xch" {
  description = "Fixed private IP for the first Active Directory server"
  default = "10.0.11.11"
}
variable "domain1_name_xch" {
  description = "Name for the Domain 1 DC"
  default = "xch01"
}
variable "domain1_cidr_public" {
  description = "CIDR of the private subnet used by the first domain"
  default = "10.0.10.0/24"
}
variable "domain1_ip_private_rdgw" {
  description = "Fixed private IP for the Remote Desktop Gateway Server"
  default = "10.0.10.10"
}
variable "domain1_name_rdgw" {
  description = "Name for the Domain 1 Remote Desktop Gateway Server"
  default = "rdgw01"
}
variable "domain1_restoremodepassword" {
  description = "Password for Restore Mode for both domains. Must be at least 8 characters containing letters, numbers and symbols"
  default = "CHANGEME"
}
variable "domain1_admin_user" {
  description = "Name for the Domain Admin account"
  default = "awsdomainadmin"
}
variable "domain1_admin_pass" {
  description = "Password for the Domain Admin account"
  default = "CHANGEME"
}

# Domain 2 Details
variable "domain2_dnsname" {
  description = "FQDN of the second forest root domain"
  default = "fabrikam.com"
}
variable "domain2_netbiosname" {
  description = "NetBIOS name of the second domain (upto 15 characters)"
  default = "FABRIKAM"
}
variable "domain2_cidr_private" {
  description = "CIDR of the private subnet used by the second domain"
  default = "10.0.21.0/24"
}
variable "domain2_ip_private_dc" {
  description = "Fixed private IP for the second Active Directory server"
  default = "10.0.21.10"
}
variable "domain2_name_dc" {
  description = "Name for the Domain 2 DC"
  default = "dc02"
}
variable "domain2_ip_private_admt" {
  description = "Fixed private IP for the Active Directory Migration Tool Server"
  default = "10.0.21.11"
}
variable "domain2_name_admt" {
  description = "Name for the Active Directory Migration Tool Server"
  default = "admt02"
}
variable "domain2_cidr_public" {
  description = "CIDR of the private subnet used by the second domain"
  default = "10.0.20.0/24"
}
variable "domain2_ip_private_rdgw" {
  description = "Fixed private IP for the Remote Desktop Gateway Server"
  default = "10.0.20.10"
}
variable "domain2_name_rdgw" {
  description = "Name for the Domain 2 Remote Desktop Gateway Server"
  default = "rdgw02"
}
variable "domain2_restoremodepassword" {
  description = "Password for Restore Mode for both domains. Must be at least 8 characters containing letters, numbers and symbols"
  default = "CHANGEME"
}
variable "domain2_admin_user" {
  description = "Name for the Domain Admin account"
  default = "awsdomainadmin"
}
variable "domain2_admin_pass" {
  description = "Password for the Domain Admin account"
  default = "CHANGEME"
}

# Deployment Controls
variable "deploy_domain1_dc" {
  description = "Deploy Domain 1 Domain Controller"
  default = 0
}
variable "deploy_domain1_rdgw" {
  description = "Deploy Domain 1 Remote Desktop Gateway"
  default = 0
}
variable "deploy_domain1_xch" {
  description = "Deploy Domain 1 Domain Controller"
  default = 0
}
variable "deploy_domain2_dc" {
  description = "Deploy Domain 2 Domain Controller"
  default = 0
}
variable "deploy_domain2_rdgw" {
  description = "Deploy Domain 2 Remote Desktop Gateway"
  default = 0
}
variable "deploy_domain2_admt" {
  description = "Deploy Domain 2 AD Migration Tool"
  default = 0
}
