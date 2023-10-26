# terrafrom import <resource-type>.<reference-name> instance-id
# Terraform can import existing infrastructure resources. This functionality lets you bring existing resources under Terraform management.
# resource block would be fine
resource "aws_instance" "webserver" {
  ami           = "ami-0571c1aedb4b8c5fc"
  instance_type = "t2.micro"
  tags = {
    Name = "sudhamsh"
  }

}