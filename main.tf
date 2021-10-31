provider "aws" {
  region  = "us-east-1"
  shared_credentials_file = "/home/jberger/.aws/credentials"
  profile = "home"
}

# S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform" {
  bucket = "rearc-project-tfstate"
}

terraform {
  backend "s3" {
    bucket = "rearc-project-tfstate"
    key    = "quest.json"
    region = "us-east-1"
  }
}

resource "aws_instance" "rearc_server" {
  ami           = "ami-0ea00bb70e6d7d222"
  instance_type = "t2.micro"

  tags = {
    Name = "RearcServerInstance"
  }
}
