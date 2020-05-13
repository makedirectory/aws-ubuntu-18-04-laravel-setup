#! /usr/bin/env bash

# Setup .env file
printf "\nYou've got to setup the .env file\n"
cd ~/"$SUBDOMAIN""$DOMAIN".com

# Set App Name
echo -n "What is the App Name? "
read APPNAME
echo -n "Would you like to use $APPNAME? - Y or N: "
read APPNAMEANSWER
APPNAMEANSWER=`echo $APPNAMEANSWER | tr "[:lower:]" "[:upper:]"`
until [ $APPNAMEANSWER == 'Y' ]; do
    echo -n "What is the App Name? "
    read APPNAME
    echo -n "Would you like to use $APPNAME? - Y or N: "
    read APPNAMEANSWER
    APPNAMEANSWER=`echo $APPNAMEANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "App Name Set"

# Set Session Driver
SESSION_DRIVER=mongodb
echo -n "What is the Session Driver? (Default is mongodb) "
read SESSION_DRIVER
echo -n "Would you like to use $SESSION_DRIVER? - Y or N: "
read SDRIVERANSWER
SDRIVERANSWER=`echo $SDRIVERANSWER | tr "[:lower:]" "[:upper:]"`
until [ $SDRIVERANSWER == 'Y' ]; do
    echo -n "What is the Session Driver? (Default is mongodb) "
    read SESSION_DRIVER
    echo -n "Would you like to use $SESSION_DRIVER? - Y or N: "
    read SDRIVERANSWER
    SDRIVERANSWER=`echo $SDRIVERANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "App Name Set"

APP_ENV=production
APP_DEBUG=false
APP_URL=https://"$SUBDOMAIN""$DOMAIN".com
LOG_CHANNEL=stack
CACHE_DRIVER=file
SESSION_LIFETIME=120
QUEUE_DRIVER=sync

# Get Mongo Variables
# This Variable is set is src/dependencies.sh @ # Install MongoDB
if [ $ADDMONGORESPONSE == 'Y' ]; then
    bash env-mongo.sh
else
    printf "\nSkipping MongoDB ENV Setup"
fi

# Get Sentry DSN
echo -n "Would you like to setup Sentry Error Reporting? - Y or N: "
read SENTRYRESPONSE
SENTRYRESPONSE=`echo $SENTRYRESPONSE | tr "[:lower:]" "[:upper:]"`
if [ $SENTRYRESPONSE == 'Y' ]; then
    echo -n "What is the SENTRY LARAVEL DSN? "
    read SENTRYDSN
    echo -n "Would you like to use $SENTRYDSN? - Y or N: "
    read SENTRYDSNANSWER
    SENTRYDSNANSWER=`echo $SENTRYDSNANSWER | tr "[:lower:]" "[:upper:]"`
    until [ $SENTRYDSNANSWER == 'Y' ]; do
        echo -n "What is the SENTRY LARAVEL DSN? "
        read SENTRYDSN
        echo -n "Would you like to use $SENTRYDSN? - Y or N: "
        read SENTRYDSNANSWER
        SENTRYDSNANSWER=`echo $SENTRYDSNANSWER | tr "[:lower:]" "[:upper:]"`
    done
    echo "SENTRY_LARAVEL_DSN Set"
else
    printf "\nSkipping Sentry ENV Setup"
fi

# Get AWS S3 Variables
echo -n "Would you like to setup an AWS S3 Bucket? - Y or N: "
read ADDAWSS3RESPONSE
ADDAWSS3RESPONSE=`echo $ADDAWSS3RESPONSE | tr "[:lower:]" "[:upper:]"`
if [ $ADDAWSS3RESPONSE == 'Y' ]; then
    bash env-aws-s3.sh
else
    printf "\nSkipping AWS S3 Bucket ENV Setup"
fi

# Get AWS SES Variables
echo -n "Would you like to setup an AWS SES Account? - Y or N: "
read ADDAWSSESRESPONSE
ADDAWSSESRESPONSE=`echo $ADDAWSSESRESPONSE | tr "[:lower:]" "[:upper:]"`
if [ $ADDAWSSESRESPONSE == 'Y' ]; then
    bash env-aws-ses.sh
else
    printf "\nSkipping AWS SES Account ENV Setup"
fi

# Get Twilio Variables
echo -n "Would you like to setup a Twilio Account? - Y or N: "
read ADDTWILIORESPONSE
ADDTWILIORESPONSE=`echo $ADDTWILIORESPONSE | tr "[:lower:]" "[:upper:]"`
if [ $ADDTWILIORESPONSE == 'Y' ]; then
    bash env-twilio.sh
else
    printf "\nSkipping Twilio Account ENV Setup"
fi

# Base .env File
echo "APP_NAME=$APP_NAME
APP_ENV=$APP_ENV
APP_KEY=
APP_DEBUG=$APP_DEBUG
APP_URL=$APP_URL

LOG_CHANNEL=$LOG_CHANNEL

SESSION_DRIVER=$SESSION_DRIVER
QUEUE_DRIVER=$QUEUE_DRIVER
" > /var/www/"$SUBDOMAIN""$DOMAIN".com/.env
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\n.evn generated\n"
else
    printf "\n.evn generation failed\n"
fi

# Adds MongoDB
if [ $ADDMONGORESPONSE == 'Y' ]; then
    echo "

    DBCONNECTION=$DBCONNECTION
    DATABASEDSN=\"$DATABASEDSN\"
    DATABASENAME=$DATABASENAME
    " >> /var/www/"$SUBDOMAIN""$DOMAIN".com/.env
    RESULT=$?
    if [ "$RESULT" -eq 0 ]; then
        printf "\nMongoDB Added to .env\n"
    else
        printf "\nMongoDB not added to .env\n"
    fi
else
    printf "\nSkipping MongoDB ENV Setup"
fi

# Adds Sentry Error Reporting
if [ $SENTRYRESPONSE == 'Y' ]; then
    echo "
    SENTRYDSN=$SENTRYDSN
    " >> /var/www/"$SUBDOMAIN""$DOMAIN".com/.env
    RESULT=$?
    if [ "$RESULT" -eq 0 ]; then
        printf "\nSentry Error Reporting to .env\n"
    else
        printf "\nFailed to add entry Error Reporting to .env\n"
    fi
else
    printf "\nSkipping Sentry Error Reporting ENV Setup"
fi

# Adds AWS S3 Bucket
if [ $ADDAWSS3RESPONSE == 'Y' ]; then
    echo "

    AWSKEYID=$AWSKEYID
    AWSSECRETKEYID=$AWSSECRETKEYID
    AWSREGION=$AWSREGION
    AWSBUCKET=$AWSBUCKET
    AWSCFURL=\"$AWSCFURL\"
    AWSMIXCFURL=\"$AWSMIXCFURL\"
    " >> /var/www/"$SUBDOMAIN""$DOMAIN".com/.env
    RESULT=$?
    if [ "$RESULT" -eq 0 ]; then
        printf "\nAWS S3 Bucket Added to .env\n"
    else
        printf "\nAWS S3 Bucket not added to .env\n"
    fi
else
    printf "\nSkipping AWS S3 Bucket ENV Setup"
fi

# Adds AWS SES Account
if [ $ADDAWSSESRESPONSE == 'Y' ]; then
    echo "

    SESKEY=$SESKEY
    SESKEYSECRET=\"$SESKEYSECRET\"
    " >> /var/www/"$SUBDOMAIN""$DOMAIN".com/.env
    RESULT=$?
    if [ "$RESULT" -eq 0 ]; then
        printf "\nAWS SES Keys Added to .env\n"
    else
        printf "\nFailed to add AWS SES Keys to .env\n"
    fi
else
    printf "\nSkipping AWS SES Keys ENV Setup"
fi

# Adds Twilio Keys
if [ $ADDTWILIORESPONSE == 'Y' ]; then
    echo "

    TWILIOSID=$TWILIOSID
    TWILIOTOKEN=$TWILIOTOKEN
    TWILIONUMBER=\"$TWILIONUMBER\"
    " >> /var/www/"$SUBDOMAIN""$DOMAIN".com/.env
    RESULT=$?
    if [ "$RESULT" -eq 0 ]; then
        printf "\nTwilio Keys Added to .env\n"
    else
        printf "\nFailed to add Twilio Keys to .env\n"
    fi
else
    printf "\nSkipping Twilio ENV Setup"
fi
