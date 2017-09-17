#!/bin/bash

#Updating
sudo yum update -y

#Install Apache
sudo yum install -y httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

#Install MySQL
sudo yum install -y mariadb-server mariadb
sudo systemctl start mariadb
sudo mysql_secure_installation
sudo systemctl enable mariadb.service

#Install PHP
sudo yum install -y php php-mysql
sudo systemctl restart httpd.service

# Configure Firewall
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

sudo yum install -y git
