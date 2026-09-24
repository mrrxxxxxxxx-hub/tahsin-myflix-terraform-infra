terraform {
  backend "s3" {
    bucket = "tahsin-s3-terraformstate"
    key = "myflix-infra/terraform.tfstate"
    region = "ap-south-1"
    use_lockfile = true
  }

}
# AWS Provider Setup
provider "aws" {
  region = "ap-south-1" # Mumbai Region
}

module "my_network" {
  source = "./modules/vpc"
  aws_vpc = var.aws_vpc
  aws_subnet = var.aws_subnet 
  availability_zone = var.availability_zone 
  aws_route_table_cidr = var.aws_route_table_cidr
  sg_ssh_port = var.sg_ssh_port
  sg_app_port = var.sg_app_port 
}

module "my_ec2" {
  source = "./modules/ec2"
  aws_instance_type = var.aws_instance_type
  subnet_id = module.my_network.subnet_ids
  vpc_security_group_id = module.my_network.security_group_ids
  aws_instance_name = var.aws_instance_name
  AWS_ACCESS_KEY_ID = var.AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  AWS_REGION = var.AWS_REGION
  AWS_BUCKET_NAME = var.AWS_BUCKET_NAME
  DB_HOST = var.DB_HOST
  DB_USER = var.DB_USER
  DB_PASSWORD = var.DB_PASSWORD
  DB_NAME = var.DB_NAME
  DB_PORT = var.DB_PORT
}  

output "ec2_public_ip" {
  description = "MyFlix Server ka Public IP"
  value       = module.my_ec2.ec2_ip_out
}