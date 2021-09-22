#!/bin/bash
sudo yum update
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<h1>Nginx was deployed successfully using terraform on $(hostname -f)</h1>" > /usr/share/nginx/html/index.html
echo "<h1>Nginx was deployed successfully using terraform on $(hostname -f)</h1>" > /var/www/html/index.html