#! /usr/bin/env bash

# SSL Setup
sudo certbot --nginx
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nSSL setup complete\n"
else
    printf "\nSSL setup failed\n"
fi

# Setup SSL crontab job
sudo bash -c 'echo "

# Renew SSL via certbot
43 6 * * * certbot renew --renew-hook "systemctl reload nginx"" >> /etc/crontab'

cat /etc/crontab
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nCrontabs Added\n"
else
    printf "\nCrontabs failed\n"
fi

printf "\nYou still need to add application specific crontabs if necessary.\n"
