#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "Welcome Http Server" >> /var/www/html/index.html
