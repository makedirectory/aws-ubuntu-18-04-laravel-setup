#! /usr/bin/env bash

# Twilio Variables
echo -n "What is the TWILIO SID? "
read TWILIOSID
echo -n "Would you like to use $TWILIOSID? - Y or N: "
read TWILIOSIDANSWER
TWILIOSIDANSWER=`echo $TWILIOSIDANSWER | tr "[:lower:]" "[:upper:]"`
until [ $TWILIOSIDANSWER == 'Y' ]; do
    echo -n "What is the TWILIO SID? "
    read TWILIOSID
    echo -n "Would you like to use $TWILIOSID? - Y or N: "
    read TWILIOSIDANSWER
    TWILIOSIDANSWER=`echo $TWILIOSIDANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "TWILIO_SID Set"

echo -n "What is the TWILIO Token? "
read TWILIOTOKEN
echo -n "Would you like to use $TWILIOTOKEN? - Y or N: "
read TWILIOTOKENANSWER
TWILIOTOKENANSWER=`echo $TWILIOTOKENANSWER | tr "[:lower:]" "[:upper:]"`
until [ $TWILIOTOKENANSWER == 'Y' ]; do
    echo -n "What is the TWILIO Token? "
    read TWILIOTOKEN
    echo -n "Would you like to use $TWILIOTOKEN? - Y or N: "
    read TWILIOTOKENANSWER
    TWILIOTOKENANSWER=`echo $TWILIOTOKENANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "TWILIO_TOKEN Set"

echo "Example format (555) 555-5555"
echo -n "What is the TWILIO Number? "
read TWILIONUMBER
echo -n "Would you like to use \"$TWILIONUMBER\"? - Y or N: "
read TWILIONUMBERANSWER
TWILIONUMBERANSWER=`echo $TWILIONUMBERANSWER | tr "[:lower:]" "[:upper:]"`
until [ $TWILIONUMBERANSWER == 'Y' ]; do
    echo -n "What is the TWILIO Number? "
    read TWILIONUMBER
    echo -n "Would you like to use \"$TWILIONUMBER\"? - Y or N: "
    read TWILIONUMBERANSWER
    TWILIONUMBERANSWER=`echo $TWILIONUMBERANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "TWILIO_NUMBER Set"
