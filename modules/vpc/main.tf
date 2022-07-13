##### VPC #####

resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = { Name = "Demo VPC" }
}

##### Internet Gateway ##### // required for public subnet

resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id                        //take vpc id
  tags = { Name = "Internet Gateway" }
}

## You can not launch NAT Gateway without Elastic IP address associated with it, that’s why aws_eip required

resource "aws_eip" "nat_gw_eip" {
  vpc = true
}

##### NAT Gateway #####

resource "aws_nat_gateway" "elasticip" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.PrivateSubnet.id

  tags = { Name = "NAT Gateway" }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.my_vpc_igw]
}




##### Security group for Public Subnet #####

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_sg"
  description = "Allow SSH inbound connections"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = { Name = "allow_ssh_sg" }
}



##### Public Subnet #####

resource "aws_subnet" "PublicSubnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pubsubnet_cidr
  availability_zone = "ap-south-1b"

  tags = { Name = "Public Subnet" }
}


##### Route Table for Public Subnet #####

resource "aws_route_table" "public_RT" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_vpc_igw.id         //take id of IG
    }

    tags = { Name = "Public Subnet Route Table" }
}

##### Associate Public subnet with Public Route Table #####

resource "aws_route_table_association" "public_RT" {
    subnet_id = aws_subnet.PublicSubnet.id
    route_table_id = aws_route_table.public_RT.id
}


##### Private Subnet #####

resource "aws_subnet" "PrivateSubnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.prisubnet_cidr
  availability_zone = "ap-south-1b"

  tags = { Name = "Private Subnet" }
}

##### Route Table for Private Subnet #####

resource "aws_route_table" "private_RT" {
    vpc_id = aws_vpc.my_vpc.id

    tags = { Name = "Private Subnet Route Table" }
}

##### Associate Private subnet with Private Route Table #####

resource "aws_route_table_association" "private_RT" {
    subnet_id = aws_subnet.PrivateSubnet.id
    route_table_id = aws_route_table.private_RT.id
}

