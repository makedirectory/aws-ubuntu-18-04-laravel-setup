#! /usr/bin/env bash

# AWS SES Variables
echo -n "What is the SES Key? "
read SESKEY
echo -n "Would you like to use $SESKEY? - Y or N: "
read SESKEYANSWER
SESKEYANSWER=`echo $SESKEYANSWER | tr "[:lower:]" "[:upper:]"`
until [ $SESKEYANSWER == 'Y' ]; do
    echo -n "What is the SES Key? "
    read SESKEY
    echo -n "Would you like to use $SESKEY? - Y or N: "
    read SESKEYANSWER
    SESKEYANSWER=`echo $SESKEYANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "SES_KEY Set"

echo -n "What is the SES Key Secret? "
read SESKEYSECRET
echo -n "Would you like to use \"$SESKEYSECRET\"? - Y or N: "
read SESKEYSECRETANSWER
SESKEYSECRETANSWER=`echo $SESKEYSECRETANSWER | tr "[:lower:]" "[:upper:]"`
until [ $SESKEYANSWER == 'Y' ]; do
    echo -n "What is the SES Key Secret? "
    read SESKEYSECRET
    echo -n "Would you like to use \"$SESKEYSECRET\"? - Y or N: "
    read SESKEYSECRETANSWER
    SESKEYSECRETANSWER=`echo $SESKEYSECRETANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "SES_SECRET Set"
