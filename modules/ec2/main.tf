resource "aws_instance" "web" {

    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.keypair_id
    tags = { Name = var.ec2name }  


    vpc_security_group_ids = var.security_groups
    subnet_id = var.subnet_web
}