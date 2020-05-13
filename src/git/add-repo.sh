#! /usr/bin/env bash

### Adding Repo

# Declaring Github UserName
echo -n "What is your GitHub User Name as it appears in a URL?: "
read GHUSER
GHUSER=`echo $GHUSER | tr "[:upper:]" "[:lower:]"`
echo "Username is:" $GHUSER
echo -n "Is this correct? - Y or N: "
read GHUSERRESPONSE
GHUSERRESPONSE=`echo $GHUSERRESPONSE | tr "[:lower:]" "[:upper:]"`
until [ $GHUSERRESPONSE == 'Y' ]; do
    echo -n "What is your GitHub User Name as it appears in a URL?: "
    read GHUSER
    GHUSER=`echo $GHUSER | tr "[:upper:]" "[:lower:]"`
    echo "Username is:" $GHUSER
    echo -n "Is this correct? - Y or N: "
    read GHUSERRESPONSE
    GHUSERRESPONSE=`echo $GHUSERRESPONSE | tr "[:lower:]" "[:upper:]"`
done

# Declaring Repo Name
echo -n "What is the Repo Name?: "
read REPO
REPO=`echo $REPO | tr "[:upper:]" "[:lower:]"`
echo "Repo is:" $REPO
echo -n "Is this correct? - Y or N: "
read REPORESPONSE
REPORESPONSE=`echo $REPORESPONSE | tr "[:lower:]" "[:upper:]"`
until [ $REPORESPONSE == 'Y' ]; do
    echo -n "What is the Repo Name?: "
    read REPO
    REPO=`echo $REPO | tr "[:upper:]" "[:lower:]"`
    echo "Repo is:" $REPO
    echo -n "Is this correct? - Y or N: "
    read REPORESPONSE
    REPORESPONSE=`echo $REPORESPONSE | tr "[:lower:]" "[:upper:]"`
done

# TODO: Add other git services ie: Bitbucket
printf "\nAdd Repo\n"
sudo chmod 700 ~/.ssh/id_rsa
sudo chmod 700 ~/.ssh/id_rsa.pub
cd ~/
ssh-agent bash -c "ssh-add ~/.ssh/id_rsa; git clone git@github.com:"$GHUSER"/"$REPO" "$SUBDOMAIN""$DOMAIN".com"
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nRepo added successfully\n"
else
    printf "\nFailed to add repo\n"
fi
