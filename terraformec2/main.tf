resource "aws_instance" "my-instance" {
ami = "${lookup(var.ami, var.aws_region)}"
instance_type = var.instance_type
key_name = var.key_name
subnet_id = var.subnet_id

associate_public_ip_address = true
#vpc_security_group_ids = "${aws_security_group.ssh-allowed.id}" 

#key_name = var.key_name

tags = {
   Name = "server-1"
}

}




