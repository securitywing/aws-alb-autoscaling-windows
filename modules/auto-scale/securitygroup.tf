resource "aws_security_group" "example-security-group" {
  vpc_id = "${var.vpc_id}"
  name = "${var.name_prefix}-security-group"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["172.31.0.0/16"]
  }


  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["10.10.0.0/16"]
  } 
tags = {
    Name = "allow-ssh-from-uat-vpc"
  }
}
