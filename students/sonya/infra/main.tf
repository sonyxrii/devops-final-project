terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" 
}

# Безпечна група для SSH та веб-сервера
resource "aws_security_group" "app_sg" {
  name        = "devops-final-app-sg"
  description = "Allow inbound traffic for SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "app_server" {
  ami           = "ami-08d4ac5b6345ef8e1"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.app_sg.name]

  tags = {
    Name = "DevOpsFinalServer"
  }
}

output "instance_ip" {
  value = aws_instance.app_server.public_ip
}
