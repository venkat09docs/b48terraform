//"ap-southeast-1"
variable "region" {
  type    = string
  default = "ap-southeast-1"
}


variable "image_id" {
  type    = string
  default = "ami-02bfb7ab7fbe1bd32"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

//"terraform"
variable "keyname" {
  type    = string
  default = "terraform"
}

//"terraform"
variable "webservertags" {
  type = map(any)
  default = {
    Name = "Web Server",
    Env  = "Development"
  }
}

variable "ssh_port" {
  type    = string
  default = "22"
}

variable "http_port" {
  type    = string
  default = "80"
}

output "webserver_public_ip" {
  value = aws_instance.web-server.public_ip
}

output "webserver_public_dns" {
  value = aws_instance.web-server.public_dns
}