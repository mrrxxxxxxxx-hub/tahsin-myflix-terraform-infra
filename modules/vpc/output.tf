output "subnet_ids" {
    description = "subnet id bahar ja raha ec2 se connect hone"
    value = aws_subnet.myflix_subnet.id
}

output "security_group_ids" {
    description = "sg id bahar ja raha hai ec2 se coonect hone"
    value = aws_security_group.myflix_sg.id
}

output "vpc_ids" {
    description = "vpc id bahar ja raha hai kisi ko apna data dene"
    value = aws_vpc.myflix_vpc.id
}    