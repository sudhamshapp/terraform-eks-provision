# we have many use cases like fetching AZ information, fetching manually created resource information etc
# as you know AMI is different for different regions and may change frequently. so we can use the data sources to fetch the data dynamically from terraform

data "aws_ami" "example" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.2.20231018.2-kernel-*"]
  }
}
data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_instance" "webserver" {
  ami           = data.aws_ami.example.id
  instance_type = "t2.micro"
  tags = {
    Name = "fetched-the-ami-using-the-data-source"
  }

}

output "ami-id" {
  value = data.aws_ami.example.id

}
output "az" {
  value = data.aws_availability_zones.available.names

}