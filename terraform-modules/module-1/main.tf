terraform {
  required_version = ">=0.12"
}

resource "aws_instance" "ec2_example" {

    ami = "ami-0efcece6bed30fd98"
    instance_type = "t2.micro"
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

  user_data = <<-EOF
      #!/bin/sh
      sudo apt-get update
      sudo apt install -y apache2
      sudo systemctl status apache2
      sudo systemctl start apache2
      sudo chown -R $USER:$USER /var/www/html
      sudo echo "<html><body><h1>Hello this is module-2 at instance id `curl http://169.254.169.254/latest/meta-data/instance-id` </h1></body></html>" > /var/www/html/index.html
      EOF
}

resource "aws_security_group" "main" {
    name        = "EC2-webserver-SG-1"
  description = "Webserver for EC2 Instances"

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZeSLhCgO6jN+5kYYrGTYzmNfv7VXye7Yh9efOYo/L3taYI9HwwKWZeNsLs7znzTWflSSVPMDHrFAANrgh4rkabeSYb7SmFIWDJ0wnj/9b1gOY6q6ilL07/8JOXQK9USYL0/r2K21nJdAUOiPsfjI+esVyb/lvllG9eeWPtBU5aYOUn1x4p/mh9+DBPpZgf6Nkt3jG7+olK7pkCgfa8Lw3LUR934Uh8ekRKy3txm9rDCGfZ8knEqK6q3mtewGWWszb3EyArc0cgtZpNeTKe7Sx4YszEsuRU3RTXEHwYtusCiJqF5oSkmY4kXb/wTgKWA3EoWk0DhTc8df5OPylLAct"
}
