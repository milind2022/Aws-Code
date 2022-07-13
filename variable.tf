##### Provider #####
variable "region" { type = string }
variable "access_key" { type = string }
variable "secret_key" { type = string }

##### Instance #####

variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "keypair_id" { type = string }
variable "ec2name" { type = string }


variable "vpc_cidr" { type = string }
variable "pubsubnet_cidr" { type = string }
variable "prisubnet_cidr" { type = string }

