#!/bin/bash
sudo su -
yum install -y httpd
curl http://169.254.169.254/latest/meta-data/instance-id -o /var/www/html/index.html
systemctl start httpd
systemctl enable httpd