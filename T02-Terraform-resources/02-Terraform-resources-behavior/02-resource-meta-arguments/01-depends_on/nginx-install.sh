#!/bin/bash
sudo yum update
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<h1>Nginx was deployed successful using terraform" > /usr/share/nginx/html/index.html
echo "<h1>Nginx was deployed successful using terraform" > /var/www/html/index.html