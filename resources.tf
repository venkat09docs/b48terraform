
resource "aws_security_group" "webserver_sg" {
  name        = "Webserver SG"
  description = "Allow SSH and HTTP ports"
  //vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH Protocol"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Http Protocol"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Webserver SG"
  }
}

resource "aws_instance" "web-server" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = var.keyname
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  user_data = file("httpserver.sh")

  tags = var.webservertags
}
