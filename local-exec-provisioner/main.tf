resource "aws_instance" "name" {
  ami           = "ami-0571c1aedb4b8c5fc"
  key_name      = "sudhamsh-dev"
  instance_type = "t3.micro"
  tags = {
    Name = "webserver"
  }
  provisioner "local-exec" {
    command = "touch sudhamsh.txt"

  }
}