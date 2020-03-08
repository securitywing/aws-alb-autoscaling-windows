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
    eu-west-2 = "ami-0c38fa95a3a62677f"
    eu-west-1 = "ami-0f26101934dec146b"
  }
}


variable "name_prefix" {
   default = "example"
 }


###################
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

variable "main-private-1" {
  default = "subnet-04614a8d8b21ffe30"
}

variable "main-private-2" {
  default = "subnet-037843d9b77a2ed30"
}
variable "public_subnets" {
   default = [ "subnet-7ea97f18", "subnet-1371d55b" ]
}



####################

