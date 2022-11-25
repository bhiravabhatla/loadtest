terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
  profile = "tw-idfc"
}

data "aws_key_pair" "example" {
  key_name           = "loadtest"
  include_public_key = true
}

data "template_file" "userdata" {
  template = "run.sh"
}


resource "aws_instance" "web" {
  count = 10
  ami           = "ami-0b51e9873bb6e11cc"
  instance_type = "t3.micro"
  key_name = data.aws_key_pair.example.key_name
  subnet_id = "subnet-4c6b0f37"
  user_data = data.template_file.userdata.rendered
  vpc_security_group_ids = ["sg-076e426e0b32fc984"]
  tags = {
    Name = "HelloWorld"
  }
}

output "ip" {
  value = aws_instance.web[0].public_ip
}