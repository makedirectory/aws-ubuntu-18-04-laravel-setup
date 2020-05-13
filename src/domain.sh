#! /usr/bin/env bash

# Declaring the Domain
echo -n "Enter Your Domain: "
read DOMAIN
DOMAIN=`echo $DOMAIN | tr "[:upper:]" "[:lower:]"`
echo "Domains are:" $DOMAIN.com www.$DOMAIN.com
echo -n "Is this correct? - Y or N: "
read DOMAINRESPONSE
DOMAINRESPONSE=`echo $DOMAINRESPONSE | tr "[:lower:]" "[:upper:]"`
until [ $DOMAINRESPONSE == 'Y' ]; do
    echo -n "Enter Your Domain: "
    read DOMAIN
    DOMAIN=`echo $DOMAIN | tr "[:upper:]" "[:lower:]"`
    echo "Domains are:" $DOMAIN.com www.$DOMAIN.com
    echo -n "Is this correct? - Y or N: "
    read DOMAINRESPONSE
    DOMAINRESPONSE=`echo $DOMAINRESPONSE | tr "[:lower:]" "[:upper:]"`
done

# Declaring the subdomain
echo -n "Would you like to setup a Subdomain? - Y or N: "
read SETSUBDOMAINRESPONSE
SETSUBDOMAINRESPONSE=`echo $SETSUBDOMAINRESPONSE | tr "[:lower:]" "[:upper:]"`
if [ $SETSUBDOMAINRESPONSE == 'Y' ]; then
    # TODO: Add '.' behind Sudmain if used
    echo -n "Enter Your Subdomain: "
    read SUBDOMAIN
    SUBDOMAIN=`echo $SUBDOMAIN | tr "[:upper:]" "[:lower:]"`
    SUBDOMAIN=${SUBDOMAIN}.
    echo "Domains are:" "$SUBDOMAIN""$DOMAIN".com www."$SUBDOMAIN""$DOMAIN".com
    echo -n "Is this correct? - Y or N: "
    read SUBDOMAINRESPONSE
    SUBDOMAINRESPONSE=`echo $SUBDOMAINRESPONSE | tr "[:lower:]" "[:upper:]"`
    until [ $SUBDOMAINRESPONSE == 'Y' ]; do
        echo -n "Enter Your Subdomain: "
        read SUBDOMAIN
        SUBDOMAIN=`echo $SUBDOMAIN | tr "[:upper:]" "[:lower:]"`
        SUBDOMAIN=${SUBDOMAIN}.
        echo "Domains are:" "$SUBDOMAIN""$DOMAIN".com www."$SUBDOMAIN""$DOMAIN".com
        echo -n "Is this correct? - Y or N: "
        read SUBDOMAINRESPONSE
        SUBDOMAINRESPONSE=`echo $SUBDOMAINRESPONSE | tr "[:lower:]" "[:upper:]"`
    done
else
    printf "\nSkipping Subdomain Setup\n"
fi
