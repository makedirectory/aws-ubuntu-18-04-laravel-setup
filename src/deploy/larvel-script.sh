#! /usr/bin/env bash

# Depoy script
cd ~/aws-ubuntu-18-04-laravel-setup
touch .provision.sh

echo -n "What Branch would you like to use? "
read GITBRANCH
echo -n "Would you like to use $GITBRANCH? - Y or N: "
read GITBRANCHANSWER
GITBRANCHANSWER=`echo $GITBRANCHANSWER | tr "[:lower:]" "[:upper:]"`
until [ $GITBRANCHANSWER == 'Y' ]; do
    echo -n "What Branch would you like to use? "
    read GITBRANCH
    echo -n "Would you like to use $GITBRANCH? - Y or N: "
    read GITBRANCHANSWER
    GITBRANCHANSWER=`echo $GITBRANCHANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "Git Branch set to $GITBRANCH"


echo "cd /var/www/"$SUBDOMAIN""$DOMAIN".com
git pull origin $GITBRANCH
composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev
echo "Reloading PHP" | sudo -S service php7.3-fpm reload

npm install
npm run production

php artisan view:clear
php artisan view:cache
php artisan config:clear
php artisan config:cache" > .provision.sh
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nProvisioning script created\n"
else
    printf "\nProvisioning script failed\n"
fi
