#! /usr/bin/env bash

# Adding SSH Key for Github
echo -n "Have you created an SSH key (for Github Repo Access)? - Y or N: "
read SSHANSWER
SSHANSWER=`echo $SSHANSWER | tr "[:lower:]" "[:upper:]"`

# Adding email for SSH Key
if [ $SSHANSWER == 'N' ]; then
    echo -n "We'll need an eMail address for the ssh key... "
    read SSHEMAIL
    echo -n "Would you like to use $SSHEMAIL? - Y or N: "
    read SSHEMAILANSWER
    SSHEMAILANSWER=`echo $SSHEMAILANSWER | tr "[:lower:]" "[:upper:]"`
    if [ $SSHEMAILANSWER == 'Y' ]; then
        # cd .ssh/
        ssh-keygen -t rsa -b 4096 -C "$SSHEMAIL"
        printf "%s\n" "" "Please create a new deploy key on Github with this key" ""
        cat ~/.ssh/id_rsa.pub
        echo ""
    else
        until [ $SSHEMAILANSWER == 'Y' ]; do
            echo -n "We'll need an eMail address for the ssh key... "
            read SSHEMAIL
            echo -n "Would you like to use $SSHEMAIL? - Y or N: "
            read SSHEMAILANSWER
            SSHEMAILANSWER=`echo $SSHEMAILANSWER | tr "[:lower:]" "[:upper:]"`
            if [ $SSHEMAILANSWER == 'Y' ]; then
                #cd .ssh/
                ssh-keygen -t rsa -b 4096 -C "$SSHEMAIL"
                printf "%s\n" "" "Please create a new deploy key on Github with this key" ""
                cat ~/.ssh/id_rsa.pub
                echo ""
            fi
        done
    fi
    # Complete SSH key setup
    echo -n "Once complete, please enter 'Done' "
    read SSHCOMPLETE

    until [[ "$SSHCOMPLETE" == 'Done' || "$SSHCOMPLETE" == 'done' ]]; do
        echo -n "Once complete, please enter 'Done' "
        read SSHCOMPLETE
    done
fi
