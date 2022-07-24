#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<h1>Nginx was deployed successful using terraform on $(hostname -f)</h1>" > /usr/share/nginx/html/index.html
echo "<h1>Nginx was deployed successful using terraform on $(hostname -f)</h1>" > /var/www/html/index.html