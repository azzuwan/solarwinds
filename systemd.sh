#!/bin/bash
#------------------------------------------------------------------------------------
# Name: systemd.sh
# Author: Azzuwan Aziz
# Created: 12/10/2020
# Email: azzuwan.aziz@pccw.com
#------------------------------------------------------------------------------------
# Description:
# This script will query SystemD systemctl to find out if $1 is actively running
# ------------------------------------------------------------------------------------
# Usage : systemd.sh
#-------------------------------------------------------------------------------------
 
if (systemctl -q is-active $1)
    then
        echo "$1 is running."
        echo "Message.Status: up"
        exit 0
    else
        echo "Message.Status: down"
        echo "Message.Error: $1 service is not running"
        exit 1
fi
