provider "aws" {
    access_key = "..."
    secret_key = "..."
    region = "eu-central-1"
}

resource "aws_instance" "my_ubuntu" {
    ami = "ami-06148e0e81e5187c8"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.web_security_group.id]
    key_name = "my_first_key"
    user_data = file("script.sh")

    tags = {
        Name = "My Server"
        Owner = "Igor"
        Project = "LabOS-4"
    }
}

resource "aws_security_group" "web_security_group" {
    name = "Web Security Group"
    description = "allow http/https traffic"

    #http
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #https
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "keys" {
    key_name = "my_first_key"
    public_key = "ssh-rsa ... igor@ivb"
}