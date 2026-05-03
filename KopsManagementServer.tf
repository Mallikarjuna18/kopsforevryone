resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  //avoid this ingress rule productionn which is very vulnerable
  ingress {
    description = "Allow All Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Change this to your IP for better security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow-SSH-SG"
  }
}

# 8. Create the EC2 Instance for Kops Management Server
resource "aws_instance" "KopsManagementServer" {
  ami                         = "ami-0ec10929233384c7f"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true
  key_name                    = "K8PractiseKey" # use your own key pair name here
  iam_instance_profile        = aws_iam_instance_profile.AdminRole.name
  tags = {
    Name = "KopsManagementServer"
  }
}