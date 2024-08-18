# main.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0bb9d5b270c58052a"  
  instance_type = "t2.micro"  

  tags = {
    Name = "MyEC2Instance"
  }
}
