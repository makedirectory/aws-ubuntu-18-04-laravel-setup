#!/bin/bash

# IPtables startup script
iptables-restore < /etc/iptables.up.rules
