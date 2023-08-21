
resource "aws_security_group" "webserver_sg" {
  name        = "Webserver SG"
  description = "Allow SSH and HTTP ports"
  //vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
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

data "aws_ami" "amazon_linux_ami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web-server" {
  count = 1
  ami                    = data.aws_ami.amazon_linux_ami.id
  instance_type          = var.instance_type
  key_name               = var.keyname
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  user_data = file("httpserver.sh")

  tags = {
    Name = "${var.Tag_name}-${count.index + 1}",
    Env  = var.Tag_env
  }
}


resource "null_resource" "provisioner" {

  depends_on = [ 
    aws_instance.web-server[0]
  ]

  provisioner "local-exec" {
    command = "echo Welcome to Terraform V1 > files/index.html"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./terraform.pem")
    host     = aws_instance.web-server[0].public_ip
  }

  provisioner "file" {
    source      = "./files/"
    destination = "/tmp/"
  }

  #sudo cp /tmp/index.html /var/www/html/

   provisioner "remote-exec" {
    inline = [
      "sleep 60",
      "sudo cp /tmp/index.html /var/www/html/",      
    ]
  }

}
