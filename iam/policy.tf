
resource "aws_iam_role" "veeresh1_role" {
  name = "veeresh1_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = false
  allow_users_to_change_password = true
}
resource "aws_iam_policy" "ec2_policy" {
  #count = length(username)
  name   = "ec2_policy"
  #path   = "/"
policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
resource "aws_iam_policy_attachment" "ec2_policy_role" {
  name  = "ec2_attachment"
  roles = [aws_iam_role.veeresh1_role.name]
  policy_arn = aws_iam_policy.ec2_policy.arn
}


resource "aws_iam_instance_profile" "ec2_profile" {
  name  = "ec2_profile"
  role = aws_iam_role.veeresh1_role.name
}


resource "aws_instance" "my-test-instance" {
  ami             = "ami-09d56f8956ab235b3"
  instance_type   = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
 # the Public SSH key
  key_name = "key"
#user_data = templatefile("user_data/user_data.tpl",
#	{
#	serverName  = "var.ServerName"
	#SecureVariable = aws_ssm_parameter.parameter_one.name
#})
associate_public_ip_address = true
tags = {
   Name = "server-1"
}
}



































