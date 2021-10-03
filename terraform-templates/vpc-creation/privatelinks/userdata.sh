#!/bin/bash -v
apt-get update -y
apt-get install -y nginx > /tmp/nginx.log
sed -i 's/80\ default_server/443\ default_server/g' /etc/nginx/sites-enabled/default
sudo service nginx reload