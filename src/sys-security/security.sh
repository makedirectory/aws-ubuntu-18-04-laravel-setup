#! /usr/bin/env bash

# TODO: Add iptables config here from https://dzone.com/articles/hardening-an-aws-ec2-instance-1
# stop the standard brute force SSH attacks
sudo iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --set
sudo iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j DROP
# manage our port 80, 443, & 27017 connections
sudo iptables -A INPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 27017 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 27017 -m state --state ESTABLISHED -j ACCEPT
# allows already connected to keep going using conntrack
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
# allows your server(s) to talk to each other
sudo iptables -A INPUT -i lo -j ACCEPT

# List any other open ports
sudo netstat -ntlp | grep LISTEN
# Open a port - replace PORT with port number
# iptables -A INPUT -p tcp --dport PORT -j ACCEPT
# Close a port - replace PORT with port number
# Iptables -A INPUT -p tcp --dport PORT -j DROP
# Flush iptables
# iptables --flush
# Save iptables
sudo bash -c "iptables-save > /etc/iptables.rules"
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\niptables saved\n"
else
    printf "\nFailed to save iptables\n"
fi

# TODO test start up script
# Adds 'iptables-restore < /etc/iptables.up.rules'
cd ~/aws-ubuntu-18-04-laravel-setup
sudo cp tables.sh /etc/init.d
# chmod 755 /etc/init.d/tables.sh
sudo chmod +x /etc/init.d/tables.sh
sudo update-rc.d tables.sh defaults
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\niptables added to startup\n"
else
    printf "\nFailed to add iptables to startup\n"
fi

### ANOTHER WAY TO DO IT
# Add below to sudo crontab -e
# @reboot /path/to/script.sh


# To block the echo request a common request for DDoS attacks:
# iptables -A OUTPUT -p ICMP --ICMP-type echo-request -j DROP
# To drop certain IP addresses of known offenders.
# iptables -A INPUT -s xxx.xxx.xxx.xxx -j DROP

# TODO Test DenyHost - https://www.techrepublic.com/article/how-to-block-ssh-attacks-on-linux-with-denyhosts/
printf "\nInstall denyhosts\n"
sudo apt install -y denyhosts
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nDenyhosts Installed\n"
else
    printf "\nDenyhosts Install Failed\n"
fi

CONNECTIONIP=$(echo $SSH_CLIENT | awk '{ print $1}')
printf "%s\n" "" "Connection IP detected as $CONNECTIONIP" ""

echo -n "This is the IP of the current SSH connection, would you like to add? - Y or N: "
read CONNECTIONIPANSWER
CONNECTIONIPANSWER=`echo $CONNECTIONIPANSWER | tr "[:lower:]" "[:upper:]"`


echo -n "Do you need to add additional IP addresses? Separated by commas or blank for none "
read EXTRAIPADDRESS
echo -n "Would you like to add $EXTRAIPADDRESS? - Y or N: "
read EXTRAIPADDRESSANSWER
EXTRAIPADDRESSANSWER=`echo $EXTRAIPADDRESSANSWER | tr "[:lower:]" "[:upper:]"`
until [ $EXTRAIPADDRESSANSWER == 'Y' ]; do
    echo -n "Do you need to add any other IP addresses? Separated by commas or blank for none "
    read EXTRAIPADDRESS
    echo -n "Would you like to add $EXTRAIPADDRESS? - Y or N: "
    read EXTRAIPADDRESSANSWER
    EXTRAIPADDRESSANSWER=`echo $EXTRAIPADDRESSANSWER | tr "[:lower:]" "[:upper:]"`
done

# /etc/hosts.allow already exists

if [ $CONNECTIONIPANSWER == 'Y' ]; then
    sudo bash -c 'echo "
    # Added by Schwartz installer

    sshd: "'"$CONNECTIONIP"'" , "'"$EXTRAIPADDRESS"'"" >> /etc/hosts.allow'
else
    sudo bash -c 'echo "
    # Added by Schwartz installer

    sshd: "'"$EXTRAIPADDRESS"'"" >> /etc/hosts.allow'
fi

RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nIPs Added to hosts.allow\n"
else
    printf "\nFailed to add IPs to hosts.allow\n"
fi

cat /etc/hosts.allow

sudo systemctl restart denyhosts.service
sudo systemctl enable denyhosts.service
RESULT=$?
if [ "$RESULT" -eq 0 ]; then
    printf "\nDenyhosts Restarted Successfully\n"
else
    printf "\nDenyhosts Restart Failed\n"
fi

# TODO: MAYBE ADD EMAIL CONFIG TO DENYHOST
