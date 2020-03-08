variable "alb_name" {
 default = "example-alb"
}
variable "target_group_sticky" {
  default = true
}

variable "name_prefix" {
  default = "example"
}

variable "target_group_port" {
  default = 80
 }
variable "alb_listener_protocol_http" {
  default = "HTTP" 
}

variable "alb_listener_protocol_https" {
  default = "HTTPS"
}

variable "target_group_path" {
  default = "/"
}
variable "alb_path" {
  default = "/"
 }

variable "target_group_name" {
  default = "example-target-group" 
}

variable "AWS_REGION" {
  default = "eu-west-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "example-key"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "example-key.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    eu-west-2 = "ami-06c145d9a93d7043d"
    eu-west-1 = "ami-069bfd4a6729e03c2"
  }
}

variable "vpc_id" {
  default = "vpc-fec94a98"
}

variable "main-public-1" {
  default = "subnet-7ea97f18"
 }

variable "main-public-2" {
 default = "subnet-1371d55b"
}

variable "main-public-3" {
  default = ""
}

variable "public_subnets" {
   default = [ "subnet-7ea97f18", "subnet-1371d55b" ]
}

variable "DOMAIN" {
   default = "*.sixthgalaxy.com"
}
