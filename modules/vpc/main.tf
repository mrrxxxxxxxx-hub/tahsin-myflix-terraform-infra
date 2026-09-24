# 1. VPC (Zameen)
resource "aws_vpc" "myflix_vpc" {
  cidr_block = var.aws_vpc
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "myflix-vpc-${terraform.workspace}"
  }
}

# 2. Subnet (Kamra)
resource "aws_subnet" "myflix_subnet" {
  vpc_id = aws_vpc.myflix_vpc.id
  cidr_block = var.aws_subnet
  map_public_ip_on_launch = true 
  availability_zone = var.availability_zone

  tags = {
    Name = "myflix-subnet-${terraform.workspace}"
  }
}

# 3. Internet Gateway - IGW (Main Gate)
resource "aws_internet_gateway" "myflix_igw" {
  vpc_id = aws_vpc.myflix_vpc.id

  tags = {
    Name = "myflix-igw-${terraform.workspace}"
  }
}

# 4. Route Table - RT (Rasta/Map)
resource "aws_route_table" "myflix_rt" {
  vpc_id = aws_vpc.myflix_vpc.id

  route {
    cidr_block = var.aws_route_table_cidr
    gateway_id = aws_internet_gateway.myflix_igw.id
  }

  tags = {
    Name = "myflix-rt-${terraform.workspace}"
  }
}

# 5. Route Table Association - RTA (Map ko Subnet se jodna)
resource "aws_route_table_association" "myflix_rta" {
  subnet_id = aws_subnet.myflix_subnet.id
  route_table_id = aws_route_table.myflix_rt.id
}

# 6. Security Group - SG (Bouncer/Firewall)
resource "aws_security_group" "myflix_sg" {
  name = "myflix-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id = aws_vpc.myflix_vpc.id

  # Inbound Rules
  ingress {
    description = "Allow SSH"
    from_port = var.sg_ssh_port
    to_port = var.sg_ssh_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port = var.sg_app_port
    to_port = var.sg_app_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "myflix-sg-${terraform.workspace}"
  }
}

# 7. AMI Data Source (Operating System)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] 

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}  