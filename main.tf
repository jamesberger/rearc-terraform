provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/home/jberger/.aws/credentials"
  profile                 = "home"
}

terraform {
  backend "s3" {
    bucket = "rearc-project-tfstate"
    key    = "quest.json"
    region = "us-east-1"
  }
}

resource "aws_instance" "rearc_server" {
  ami                    = "ami-0ea00bb70e6d7d222"
  instance_type          = "t2.micro"
  key_name               = "james-home"
  vpc_security_group_ids = [aws_security_group.rearc_server_sg.id]

  tags = {
    Name = "RearcServerInstance"
  }
}


# Security group
resource "aws_security_group" "rearc_server_sg" {
  name        = "Rearc security group"
  description = "SG for access to the Rearc app instance"
  vpc_id      = "vpc-0f90020affe8fa3b3"
}

# Security group rules
resource "aws_security_group_rule" "allow-all-outbound-traffic" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rearc_server_sg.id
  description       = "Allow all outbound traffic"
}

resource "aws_security_group_rule" "rearc_ssh_instance_access" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["47.186.42.182/32"]
  security_group_id = aws_security_group.rearc_server_sg.id
  description       = "Allow SSH access from home"
}

resource "aws_security_group_rule" "rearc_app_instance_access" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = 3000
  to_port           = 3000
  cidr_blocks       = ["47.186.42.182/32"]
  security_group_id = aws_security_group.rearc_server_sg.id
  description       = "Allow app access from home"
}
