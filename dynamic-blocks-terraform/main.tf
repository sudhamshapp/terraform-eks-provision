# with the help of dynamic block we can open the multiple ports reducing the lines of code for an ingress and egress
locals {
  ingress_rules = [{
    port        = 443
    description = "ingress rules for port 443"
    },
    {
      port        = 80
      description = "ingress rules for port 80"
    },
    {
      port        = 22
      description = "ingress rules for port 22"

  }]

}

resource "aws_instance" "name" {
  ami                    = "ami-0571c1aedb4b8c5fc"
  instance_type          = "t3.micro"
  key_name               = "sudhamsh-dev"
  vpc_security_group_ids = [aws_security_group.firewall.id]

}

resource "aws_security_group" "firewall" {
  #   name        = "allow_tls"
  #   description = "Allow TLS inbound traffic"
  #   vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "firewall-to-protect-the-instance"
  }
}