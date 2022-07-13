module "vpc" {
  
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    pubsubnet_cidr = var.pubsubnet_cidr
    prisubnet_cidr = var.prisubnet_cidr
}

##### EC2 Key Pair #####

resource "aws_key_pair" "key_pair" {
  key_name   = "EC2-key"
  public_key = var.keypair_id
}

####

module "web" {

    source = "./modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    keypair_id = "EC2-key"
    ec2name = var.ec2name
    
    vpc = module.vpc.vpcid
    subnet_web = module.vpc.PubSubnet       //taken from output of vpc, add subnet_web in ec2 variable
    security_groups = module.vpc.SecGroup

    }
