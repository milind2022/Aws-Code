

variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "keypair_id" { type = string }

variable "ec2name" { type = string }


variable "subnet_web" { type = string }
variable "vpc" { type = string }
variable "security_groups" { }