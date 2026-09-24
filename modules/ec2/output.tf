output "ec2_ip_out" {
    description = "ec2 id bahar ja raha hai print hone"
    value = aws_instance.myflix_server.public_ip
}    