//"ap-southeast-1"
variable "region" {
  type    = string
  default = "ap-southeast-1"
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
variable "Tag_name" {
  default = "Web Server"
}

variable "Tag_env" {
  default = "Development"
}

variable "ports" {
  type = list
  default = [22,80,443]
  
}

output "webserver_public_ip" {
  value = aws_instance.web-server[0].public_ip
}

output "webserver_public_dns" {
  value = aws_instance.web-server[0].public_dns
}