# output basically prints the desired output on the console like instance-id, public-ip etc
resource "aws_instance" "name" {
  ami           = "ami-0571c1aedb4b8c5fc"
  instance_type = "t3.micro"
  key_name      = "sudhamsh-dev"
  tags = {
    Name = "test-server"
  }
}
output "id" {
  value = aws_instance.name.id

}
output "public-ip" {
  value = aws_instance.name.public_ip

}