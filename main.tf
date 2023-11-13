provider "aws" {
    region = "us-east-1"
  
}
resource "aws_instance" "tf_instance" {
    ami = "ami-05c13eab67c5d8861"
    instance_type = "t2.micro"  
    tags = {"Name" = "tf_instance"}
}