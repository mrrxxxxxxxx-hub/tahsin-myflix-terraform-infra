variable "aws_vpc" {
    description = "cidr ka block"
    default = "10.0.0.0/16"
}

variable "aws_subnet" {
    description = "aws ka subnet"
    default = "10.0.1.0/24"
}

variable "availability_zone" {
    description = "aws ka availability zone"
    default = "ap-south-1a"
}

variable "aws_route_table_cidr" {
    description = "aws ka route table"
    default = "0.0.0.0/0"
}

variable "sg_ssh_port" {
    description = "aws sg ka port"
    default = "22"
}

variable "sg_app_port" {
    description = "aws sg ka port"
    default = "8080"
}

variable "aws_instance_type" {
    description = "aws instance ka type"
    default = "t3.micro"
}

variable "aws_instance_name" {
    description = "aws instance ka name"
    default = "myflix-server"
}
variable "AWS_ACCESS_KEY_ID" {
    description = "aws ka access key id"
}

variable "AWS_SECRET_ACCESS_KEY" {
    description = "aws ka secret access key"
}

variable "AWS_REGION" {
    description = "aws ka region"
    default = "ap-south-1"
}

variable "AWS_BUCKET_NAME" {
    description = "aws ka bucket name"
    default = "tahsin-myflix-bucket"
}

variable "DB_HOST" {
    description = "db ka host"
    default = "tahsin-app-db.cn0c6oaswm8z.ap-south-1.rds.amazonaws.com"
}

variable "DB_USER" {
    description = "db ka username"
    default = "admin"
}

variable "DB_PASSWORD" {
    description = "db ka password"
    default = "TahsinDB111"
}

variable "DB_NAME" {
    description = "db ka name"
    default = "tahsin_app_db"
}

variable "DB_PORT" {
    description = "db ka port"
    default = "3306"
}

