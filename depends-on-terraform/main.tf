resource "aws_s3_bucket" "name" {
    bucket = "thearbitarymarsbucket"
    tags = {
        Name= "thearbitary-stuff"
    }
  
}
resource "aws_instance" "webserver" {
    ami = "ami-0571c1aedb4b8c5fc"
    instance_type = "t3.micro"
    key_name = "sudhamsh-dev"
    depends_on = [ aws_s3_bucket.name ]
  
}