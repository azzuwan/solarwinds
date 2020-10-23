#!/bin/bash
#------------------------------------------------------------------------------------
# Name: manager.sh
# Author: Azzuwan Aziz
# Created: 12/10/2020
# Email: azzuwan.aziz@pccw.com
#------------------------------------------------------------------------------------
# Description:
# This script will query docker engine for a list of nodes and filter them by
# role=manager value from the ROLES column. Then the node availability will be checked
# using the AVAILABILITY column of the list.
# ------------------------------------------------------------------------------------
# Usage : manager.sh 
#-------------------------------------------------------------------------------------

readarray -t result < <(docker node ls --format  "{{.Availability}}" --filter role=manager)
for stat in "${result[@]}"
   do
       #echo "${stat}"
       if [[ "Active" != $stat ]]; then
            echo "Statistic.Status: -1"
            echo "Message.Status: One of the leaders is down or unreachabe" 
            exit 1 
       fi
done
echo "Statistic.Status: 1"
echo "Message.Status: Up, all leaders are active"
exit 0
