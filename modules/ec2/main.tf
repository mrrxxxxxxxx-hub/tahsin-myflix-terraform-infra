# 7. AMI Data Source (Operating System)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] 

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# 8. EC2 Instance (Tera Asli Server)
resource "aws_instance" "myflix_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.aws_instance_type
  subnet_id = var.subnet_id  
  vpc_security_group_ids = [var.vpc_security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install docker.io docker-compose -y
              sudo systemctl start docker
              sudo systemctl enable docker
              cd /home/ubuntu
              sudo git clone https://github.com/mrrxxxxxxxx-hub/tahsin-raza-myflix.git
              cd tahsin-raza-myflix/
              echo "AWS_ACCESS_KEY_ID=${var.AWS_ACCESS_KEY_ID} >> .env
              echo "AWS_SECRET_ACCESS_KEY=${var.AWS_SECRET_ACCESS_KEY} >> .env
              echo "AWS_REGION=${var.AWS_REGION} >> .env
              echo "AWS_BUCKET_NAME=${var.AWS_BUCKET_NAME} >> .env
              echo "DB_HOST=${var.DB_HOST} >> .env
              echo "DB_USER=${var.DB_USER} >> .env
              echo "DB_PASSWORD=${var.DB_PASSWORD} >> .env
              echo "DB_NAME=${var.DB_NAME} >> .env
              echo "DB_PORT=${var.DB_PORT} >> .env
              sudo docker-compose up -d
              EOF

              

  tags = {
    Name = "${var.aws_instance_name}-${terraform.workspace}"
  }
}