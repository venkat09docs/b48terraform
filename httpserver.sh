#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
# echo "Welcome to Terraform V1" >> /var/www/html/index.html
