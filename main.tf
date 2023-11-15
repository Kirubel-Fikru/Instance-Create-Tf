provider "aws" {
    region = "us-east-1"
  
}
resource "aws_instance" "tf_instance" {
    ami = "ami-05c13eab67c5d8861"
    instance_type = "t2.micro"  

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.xhtml
                nohup busybox httpd -f -p 8080 &
                EOF

    user_data_replace_on_change = true

    
    tags = {"Name" = "tf_instance"}
}

resource "aws_security_group" "sg_tf" {
    name = "Security-group_tf"

    ingress =  {
        from_port=8080
        to_port=8080
        protocol = "tcp"
        cidr_blocks =["0.0.0.0./0"]
    }
    
}