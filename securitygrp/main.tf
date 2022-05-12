resource "aws_security_group" "allow_port" {
  name        = "allow_port"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "Allow internet from port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    #allow_all_outbound = false
   cidr_blocks = ["10.20.0.0/16"]
}
 ingress {
    description      = "Allow internet from port all"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    #allow_all_outbound = false
   cidr_blocks = ["0.0.0.0/0"]
}

 ingress {
    description      = "Allow internet from port 80"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    #allow_all_outbound = false
   cidr_blocks = ["10.20.0.0/16"]
}




#Outgoing traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "my-test-instance" {
  ami             = "ami-04d9e855d716f9c99"
  instance_type   = "t2.micro"
security_groups = ["allow_port"] 
 # the Public SSH key
  key_name = "veeresh-singapore"

associate_public_ip_address = true
tags = {
   Name = "veeresh-trfrmLB"
}
user_data = <<-EOF
               #!/bin/bash
               sudo apt-get update -y
               sudo apt-get install apache2 -y
               sudo mkfs -t ext4 /dev/xvdh
               sudo mount /dev/xvdh /var/www/html
               sudo git clone  https://github.com/nveeresh133/terraformimages.git /var/www/html/
	EOF
}

resource "aws_ebs_volume" "veer-ebs" {
	availability_zone = aws_instance.my-test-instance.availability_zone
	size 		  = 8
}

resource "aws_volume_attachment" "veeresh-ebs-attachment" {
        device_name = "/dev/xvdh"
        volume_id = aws_ebs_volume.veer-ebs.id
        instance_id = aws_instance.my-test-instance.id
        force_detach = true

 }
resource "aws_s3_bucket" "veer" {
  bucket = "veer-bucket133-tf"
   acl   = "public-read"

tags = {
    Name        = "veer-bucket133-tf"
    Environment = "Dev"
  }
  provisioner "local-exec" {
    command = "git clone https://github.com/nveeresh133/terraformimages.git folder"
    }
  }
  
resource "aws_s3_bucket_object" "image_upload" {
  bucket = aws_s3_bucket.veer.bucket
  key    = "karnataka.jpg"
  source = "folder/karnataka.jpg"
  acl = "public-read"
}















