variable "AWS_REGION" {    
    default = "us-east-1"
}

variable "AMI" {
    type = map    
    default = {
        us-east-1 = "ami-09d56f8956ab235b3"
}
}
resource "aws_instance" "web1" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"
    # VPC
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
    # the Public SSH key
#    key_name = "N.Virginia-region-key-pair.pem"
}
# connection {
 #       user = "${var.EC2_USER}"
  #      private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
  #  }

// Sends your public key to the instance
#resource "aws_key_pair" "N.Virginia-region-key-pair" {
 #   key_name = "N.Virginia-region-key-pair"
  #  public_key = "${file(var.PUBLIC_KEY_PATH)}"
#}















