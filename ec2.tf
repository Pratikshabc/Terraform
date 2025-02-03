#Comment
resource "aws_instance" "public_vm" {
  ami                    = "ami-05edf2d87fdbd91c1" # Amazon Linux 2 AMI (modify as needed)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  security_groups        = [aws_security_group.allow_ssh_http.name]
  key_name               = aws_key_pair.ec2_key_pair.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Public-VM"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
}

resource "aws_instance" "private_vm" {
  ami                    = "ami-05edf2d87fdbd91c1" # Amazon Linux 2 AMI (modify as needed)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  security_groups        = [aws_security_group.allow_ssh_http.name]
  key_name               = aws_key_pair.ec2_key_pair.key_name

  tags = {
    Name = "Private-VM"
  }
}

