#! /usr/bin/env bash

# Configure Nginx
printf "\nLets configure NGINX\n"
sudo rm /etc/nginx/sites-available/default
sudo cp ~/aws-ubuntu-18-04-laravel-setup/nginx_default /etc/nginx/sites-available/default

sudo sed -i s/SUBDOMAIN/${SUBDOMAIN}/g /etc/nginx/sites-available/default
sudo sed -i s/DOMAIN/${DOMAIN}/g /etc/nginx/sites-available/default

cat /etc/nginx/sites-available/default
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/"'"$SUBDOMAIN"'""'"$DOMAIN"'".com
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
sudo nginx -t
sudo service nginx restart
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nNGINX configuration complete\n"
else
    printf "\nNGINX configuration failed\n"
fi
