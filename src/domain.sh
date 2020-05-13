#! /usr/bin/env bash

# Declaring the Domain
echo -n "You'll need to setup a Domain: "
read DOMAIN
DOMAIN=`echo $DOMAIN | tr "[:upper:]" "[:lower:]"`
echo "Domains are:" $DOMAIN.com www.$DOMAIN.com
echo -n "Is this correct? - Y or N: "
read DOMAINRESPONSE
DOMAINRESPONSE=`echo $DOMAINRESPONSE | tr "[:lower:]" "[:upper:]"`
until [ $DOMAINRESPONSE == 'Y' ]; do
    echo -n "You'll need to setup a Domain: "
    read DOMAIN
    DOMAIN=`echo $DOMAIN | tr "[:upper:]" "[:lower:]"`
    echo "Domains are:" $DOMAIN.com www.$DOMAIN.com
    echo -n "Is this correct? - Y or N: "
    read DOMAINRESPONSE
    DOMAINRESPONSE=`echo $DOMAINRESPONSE | tr "[:lower:]" "[:upper:]"`
done

# Declaring the subdomain
# TODO: Make Optional and '.' behind Sudmain if used
echo -n "You'll need to setup a Subdomain: "
read SUBDOMAIN
SUBDOMAIN=`echo $SUBDOMAIN | tr "[:upper:]" "[:lower:]"`
## Add .
echo "Domains are:" "'"$SUBDOMAIN"'""'"$DOMAIN"'".com www."'"$SUBDOMAIN"'""'"$DOMAIN"'".com
echo -n "Is this correct? - Y or N: "
read SUBDOMAINRESPONSE
SUBDOMAINRESPONSE=`echo $SUBDOMAINRESPONSE | tr "[:lower:]" "[:upper:]"`
until [ $SUBDOMAINRESPONSE == 'Y' ]; do
    echo -n "You'll need to setup a Subdomain: "
    read SUBDOMAIN
    SUBDOMAIN=`echo $SUBDOMAIN | tr "[:upper:]" "[:lower:]"`
    echo "Domains are:" "'"$SUBDOMAIN"'""'"$DOMAIN"'".com www."'"$SUBDOMAIN"'""'"$DOMAIN"'".com
    echo -n "Is this correct? - Y or N: "
    read SUBDOMAINRESPONSE
    SUBDOMAINRESPONSE=`echo $SUBDOMAINRESPONSE | tr "[:lower:]" "[:upper:]"`
done
