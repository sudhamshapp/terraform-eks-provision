locals {
  staging_env = "staging"
}
resource "aws_vpc" "demo" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "${local.staging_env}-vpc"

  }

}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${local.staging_env}-subnet"
  }
}
resource "aws_instance" "webserver" {
  ami                         = "ami-0571c1aedb4b8c5fc"
  instance_type               = "t3.micro"
  key_name                    = "sudhamsh-dev"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.main.id
  tags = {
    Name = "${local.staging_env}-instance"
  }


}