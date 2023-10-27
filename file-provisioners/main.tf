# Provisioners are of three types: file, local-exec, and remote-exec
# We are going to copy the file from the local host to the destination (imagine it as an EC2 machine)

resource "aws_instance" "name" {
  ami           = "ami-0571c1aedb4b8c5fc"
  instance_type = "t3.micro"
  key_name      = "aws_key" // created using ssh-keygen -t rsa -b 2048, then opt the path explicitly where you wanna reside your keys, this key we defined in the bottom

  tags = {
    Name = "webserver"
  }

  provisioner "file" {
    source      = "/Users/mars/Documents/git-projects/terraform-eks/file-provisioners/index.html"
    destination = "/home/ec2-user/index.html"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("/Users/mars/Documents/AWS/aws_key")
    timeout     = "4m"
  }
}

resource "aws_key_pair" "cretaeddlocally" {
  key_name   = "aws_key" //this is the public-key(aws_key.pub)
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZeSLhCgO6jN+5kYYrGTYzmNfv7VXye7Yh9efOYo/L3taYI9HwwKWZeNsLs7znzTWflSSVPMDHrFAANrgh4rkabeSYb7SmFIWDJ0wnj/9b1gOY6q6ilL07/8JOXQK9USYL0/r2K21nJdAUOiPsfjI+esVyb/lvllG9eeWPtBU5aYOUn1x4p/mh9+DBPpZgf6Nkt3jG7+olK7pkCgfa8Lw3LUR934Uh8ekRKy3txm9rDCGfZ8knEqK6q3mtewGWWszb3EyArc0cgtZpNeTKe7Sx4YszEsuRU3RTXEHwYtusCiJqF5oSkmY4kXb/wTgKWA3EoWk0DhTc8df5OPylLAct"
}
