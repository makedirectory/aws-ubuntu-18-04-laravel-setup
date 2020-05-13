#! /usr/bin/env bash

# Deployment setup script - LNMP server

printf "\nLinux Nginx MongoDB PHP Server Setup\n"

# Create Swap File
# TODO: Make Optional and size variable
sudo fallocate -l 1G /swapfile
sudo mkswap /swapfile
sudo chmod 600 /swapfile
sudo swapon /swapfile
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nSwap Created\n"
    swapon -s
else
    printf "\nSwap Failed\n"
fi

# Install Dependencies
bash src/dependencies.sh
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nDependencies setup complete\n"
else
    printf "\nFailed to run Dependencies setup\n"
fi

# System Security
bash src/sys-security/security.sh
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nSecurity setup complete\n"
else
    printf "\nFailed to run Security setup\n"
fi

# Setup GitHub Repo
echo -n "Would you like to set a Github Account? - Y or N: "
read GITACCOUNTRESPONSE
GITACCOUNTRESPONSE=`echo $GITACCOUNTRESPONSE | tr "[:lower:]" "[:upper:]"`
if [ $GITACCOUNTRESPONSE == 'Y' ]; then
    bash src/git/github-setup.sh
    RESULT=$?
    if [ "$RESULT" -eq 0 ]; then
        printf "\nGitHub setup complete\n"
    else
        printf "\nFailed to run GitHub setup\n"
    fi
    # Setup GitHub SSH Key
    echo -n "Would you like to create an SSH Key for GitHub? - Y or N: "
    read GITSSHRESPONSE
    GITSSHRESPONSE=`echo $GITSSHRESPONSE | tr "[:lower:]" "[:upper:]"`
    if [ $GITSSHRESPONSE == 'Y' ]; then
        bash src/git/github-ssh-setup.sh
        RESULT=$?
        if [ "$RESULT" -eq 0 ]; then
            printf "\nSSH Key setup complete\n"
        else
            printf "\nFailed to create SSH Key\n"
        fi
    else
        printf "\nSkipping GitHub SSH Key Setup\n"
    fi
else
    printf "\nSkipping GitHub Account Setup"
fi

# Add Domain variables
bash src/domain.sh
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nDomain setup complete\n"
else
    printf "\nFailed to run Domain setup\n"
fi

# Run Add Repo Script
if [ $GITACCOUNTRESPONSE == 'Y' ]; then
    echo -n "Would you like to clone a Github Repo? - Y or N: "
    read GITCLONERESPONSE
    GITCLONERESPONSE=`echo $GITCLONERESPONSE | tr "[:lower:]" "[:upper:]"`
    if [ $GITCLONERESPONSE == 'Y' ]; then
        bash src/git/add-repo.sh
        RESULT=$?
        if [ "$RESULT" -eq 0 ]; then
            printf "\nRepo setup complete\n"
        else
            printf "\nFailed to run Repo setup\n"
        fi
    else
        printf "\nSkipping GitHub Repo setup\n"
    fi
else
    printf "\nSkipping GitHub Repo setup\n"
fi

# Setup .env File
echo -n "Would you like to setup a .env File? - Y or N: "
read ENVRESPONSE
ENVRESPONSE=`echo $ENVRESPONSE | tr "[:lower:]" "[:upper:]"`
if [ $ENVRESPONSE == 'Y' ]; then
    bash src/env/env-setup.sh
    RESULT=$?
    if [ "$RESULT" -eq 0 ]; then
        printf "\nENV setup complete\n"
    else
        printf "\nFailed to run ENV setup\n"
    fi
else
    printf "\nSkipping ENV Setup"
fi

# Move repo
sudo mv ~/"$SUBDOMAIN""$DOMAIN".com /var/www/"$SUBDOMAIN""$DOMAIN".com
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nRepo moved successfully\n"
else
    printf "\nFailed to move repo\n"
fi

# Generates a key for the .env file - must be added before `php artisan config:cache is run`
cd /var/www/"$SUBDOMAIN""$DOMAIN".com
composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev
php artisan key:generate
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nProduction key generated\n"
else
    printf "\nProduction key generation failed\n"
fi

### Depoy script
# 1. Laravel
bash deploy/laravel-script.sh
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nLaravel setup complete\n"
else
    printf "\nFailed to run Laravel setup\n"
fi

# TODO: Update config/app.php
# 'url' => env('APP_URL', 'http://localhost'), => 'url' => env('APP_URL', 'https://"$SUBDOMAIN""$DOMAIN".com'),

# Set File Permissions
bash app-permissions.sh
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nPermissions setup complete\n"
else
    printf "\nFailed to run Permissions setup\n"
fi

# Configure Nginx
bash src/nginx/nginx-setup.sh
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nNGINX setup complete\n"
else
    printf "\nFailed to run NGINX setup\n"
fi

# SSL Setup
echo -n "Would you like to setup SSL? - Y or N: "
read SSLRESPONSE
SSLRESPONSE=`echo $SSLRESPONSE | tr "[:lower:]" "[:upper:]"`
if [ $SSLRESPONSE == 'Y' ]; then
    bash src/sys-security/ssl-setup.sh
    RESULT=$?
    if [ "$RESULT" -eq 0 ]; then
        printf "\nSSL setup complete\n"
    else
        printf "\nFailed to run SSL setup\n"
    fi
else
    printf "\nSkipping SSL Setup"
fi

printf "\nCompleted in $SECONDS Seconds. Please visit www."$SUBDOMAIN""$DOMAIN".com\n"
