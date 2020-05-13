#! /usr/bin/env bash

# Setup Github Email and Username
printf "\nSetup Github\n"
echo -n "What is your Github username? "
read GITHUBUSER

echo -n "Would you like to use $GITHUBUSER? - Y or N: "
read GITHUBUSERANSWER
GITHUBUSERANSWER=`echo $GITHUBUSERANSWER | tr "[:lower:]" "[:upper:]"`
if [ $GITHUBUSERANSWER == 'Y' ]; then
    git config --global user.name "$GITHUBUSER"
else
    until [ $GITHUBUSERANSWER == 'Y' ]; do
        echo -n "What is your Github username? "
        read GITHUBUSER
        echo -n "Would you like to use $GITHUBUSER? - Y or N: "
        read GITHUBUSERANSWER
        GITHUBUSERANSWER=`echo $GITHUBUSERANSWER | tr "[:lower:]" "[:upper:]"`
        if [ $GITHUBUSERANSWER == 'Y' ]; then
            git config --global user.name "$GITHUBUSER"
        fi
    done
fi

GITUSERNAME=$(git config --global user.name)
printf "%s\n" "You've set the Github user to $GITUSERNAME" ""

echo -n "What is your Github eMail? "
read GITHUBEMAIL

echo -n "Would you like to use $GITHUBEMAIL? - Y or N: "
read GITHUBEMAILANSWER
GITHUBEMAILANSWER=`echo $GITHUBEMAILANSWER | tr "[:lower:]" "[:upper:]"`
if [ $GITHUBEMAILANSWER == 'Y' ]; then
    git config --global user.email "$GITHUBEMAIL"
else
    until [ $GITHUBEMAILANSWER == 'Y' ]; do
        echo -n "What is your Github username? "
        read GITHUBEMAIL
        echo -n "Would you like to use $GITHUBEMAIL? - Y or N: "
        read GITHUBEMAILANSWER
        GITHUBEMAILANSWER=`echo $GITHUBEMAILANSWER | tr "[:lower:]" "[:upper:]"`
        if [ $GITHUBEMAILANSWER == 'Y' ]; then
            git config --global user.name "$GITHUBUSER"
        fi
    done
fi

GITEMAIL=$(git config --global user.email)
printf "%s\n" "You've set the Github email to $GITEMAIL" ""
