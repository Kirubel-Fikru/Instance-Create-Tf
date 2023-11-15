provider "aws" {
    region = "us-east-1"
  
}

variable "server_port" {
 description = "The port the server will use for HTTP requests"
 type = number
 default = 8080

}
variable "ssh_port" {
    description = "The port number for SSH connections"
    type=  number
    default = 22
  
}

output "public_ip" {
 value = aws_instance.tf_instance.public_ip
 description = "The public IP address of the web server"
}

resource "aws_instance" "tf_instance" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"  
    vpc_security_group_ids = [aws_security_group.sg_tf.id]

    user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > /var/www/html/index.html
              service httpd start
              chkconfig httpd on
              EOF
    
    user_data_replace_on_change = true

    
    tags = {"Name" = "tf_ec2-instance"}
}

resource "aws_security_group" "sg_tf" {
    name = "Security-group_tf"

    ingress  {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     ingress  {
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
}