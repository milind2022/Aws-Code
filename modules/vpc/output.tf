output "vpcid" {
    value = aws_vpc.my_vpc.id
}

output "PubSubnet" {
    value = aws_subnet.PublicSubnet.id
}

output "SecGroup" {
    value = [ aws_security_group.allow_ssh.id ]       
}