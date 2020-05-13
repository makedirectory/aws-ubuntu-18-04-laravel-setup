#! /usr/bin/env bash

# Add Third-party Repos
sudo apt-get install -y software-properties-common
printf "\nAdded software-properties-common\n"
sudo add-apt-repository -y ppa:nginx/stable
sudo add-apt-repository -y ppa:ondrej/php
sudo add-apt-repository -y ppa:certbot/certbot
printf "\nAdded nginx, php, & certbot repos\n"

# Update OS
sudo apt update
sudo apt -y upgrade
printf "\nUpdated system\n"

# Install fail2ban
sudo apt-get install -y fail2ban
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nFail2ban Installed\n"
else
    printf "\nFail2ban Install Failed\n"
fi

# Install NGINX server
sudo apt-get install -y nginx
sudo service nginx restart
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nNginx Installed\n"
else
    printf "\nNginx Install Failed\n"
fi

# Install PHP
sudo apt-get install -y php7.3 php7.3-fpm php7.3-curl php7.3-mbstring php7.3-xml php7.3-gd php7.3-opcache redis-server zip unzip php7.3-zip #php7.3-dev php7.3-pear php7.3-gettext libapache2-mod-php7.3 php-doctrine-dbal
sudo systemctl restart php7.3-fpm
sudo systemctl status php7.3-fpm
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nPHP 7.3 Installed\n"
else
    printf "\nPHP 7.3 Install Failed\n"
fi

# Install Composer
cd ~/
curl -sS https://getcomposer.org/installer | php
sudo chmod 755 composer.phar
sudo mv composer.phar /usr/local/bin/composer
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nComposer Installed\n"
else
    printf "\nComposer Install Failed\n"
fi

# Install Mongodb
printf "\nSetup MongoDB\n"
echo -n "Would You like to use MongoDB? - Y or N: "
read ADDMONGORESPONSE
ADDMONGORESPONSE=`echo $ADDMONGORESPONSE | tr "[:lower:]" "[:upper:]"`
if [ $ADDMONGORESPONSE == 'Y' ]; then
    # Should update to use sudo pecl install mongodb
    sudo apt-get install php-mongodb
    RESULT=$?
    if [ "$RESULT" -eq 0 ]; then
        printf "\nMongoDB Installed\n"
    else
        printf "\nMongoDB Install Failed\n"
    fi
    php --ri mongodb
else
    printf "\nSkipping MongoDB Install\n"
fi

# Install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
source ~/.nvm/nvm.sh
source ~/.profile
source ~/.bashrc
nvm --version
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nNVM Installed\n"
else
    printf "\nNVM Install Failed\n"
fi

# Install npm
sudo apt install -y npm
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nNPM Installed\n"
else
    printf "\nNPM Install Failed\n"
fi

# Install node
nvm install 10.15
nvm use 10.15
nvm current
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nNode Installed\n"
else
    printf "\nNode Install Failed\n"
fi

# Install certbox
sudo apt-get install -y python-certbot-nginx
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nCertbot Installed\n"
else
    printf "\nCertbot Install Failed\n"
fi

# Restart PHP and NGINX
sudo systemctl restart php7.3-fpm
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nRestarted PHP Successfully\n"
else
    printf "\nPHP Restart Failed\n"
fi
sudo service nginx restart
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nRestarted NGINX Successfully\n"
else
    printf "\nNGINX Restart Failed\n"
fi
