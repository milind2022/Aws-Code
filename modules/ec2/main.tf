resource "aws_instance" "web" {

    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.keypair_id
    tags = { Name = var.ec2name }  
}