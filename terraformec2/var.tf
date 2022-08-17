variable "aws_region" {
    description = "EC2 region"
    default = "ap-south-1"
}

variable "aws_access_key" {
    description = "access key"
    default = "AKIA4PO2BKJ5QQPIPZKM"
}

variable "aws_secret_key" {
    description = "secret key"
    default = "s6gVBmO5JwUNxJdhuArpC5DOAkoVH3zjbZANsnJq"
}

variable "ami" {
    description = "AMI ID"
    type = map
    default = {
        ap-south-1 = "ami-068257025f72f470d"
    }
}

variable "key_name" {
    description = "Key pair name"
    type = string
    default = "yash"
}

#
variable "subnet_id" {
    description = "subnet_id"
    default = "subnet-03566395d648f0c08"
}




variable "instance_type" {
  description = "AWS EC2 instance type."
  type        = string  
  default = "t2.micro"
}








