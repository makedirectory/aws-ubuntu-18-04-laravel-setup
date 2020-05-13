#! /usr/bin/env bash

# File permissions
printf "\nSetting file permssions\n"

sudo chown -R ubuntu:www-data /var/www/"$SUBDOMAIN""$DOMAIN".com
sudo chmod -R 775 /var/www/"$SUBDOMAIN""$DOMAIN".com
sudo chown -R www-data:www-data /var/www/"$SUBDOMAIN""$DOMAIN".com/storage

# **** BEGIN: Uncomment This if NPM install fails ***** #
# sudo chown -R $USER /usr/local
# cd /var/www/"$SUBDOMAIN""$DOMAIN".com
# chmod -R a+x node_modules
# **** END: Uncomment This if NPM install fails ***** #

printf "\nDone setting file permssions\n"

# Run application install script
source ~/.nvm/nvm.sh
source ~/.profile
source ~/.bashrc
bash ~/aws-ubuntu-18-04-laravel-setup/.provision.sh
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nApplication installed\n"
else
    printf "\nApplication install failed - check src/app-permissions.sh for instructions.\n"
fi
