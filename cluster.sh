#!/bin/bash
#------------------------------------------------------------------------------------
# Name: cluster.sh
# Author: Azzuwan Aziz
# Created: 12/10/2020
# Email: azzuwan.aziz@pccw.com
#------------------------------------------------------------------------------------
# Description:
# This script will query docker engine for a list of services and then filter it down 
# to the particular service name specified from the command arguments. It will then get
# the Replicas value from the REPLICAS column of the filtered line.
# ------------------------------------------------------------------------------------
# Usage : cluster.sh example_service
#-------------------------------------------------------------------------------------

#Filter the service list with a name matching the argument supplied and strip the replicas value.
# Replica values are in the form of  running_instances / total_replica_quorum.
# Sample values: running_instance "2/2", "3/4", "0/1", "1/3"  etc...
result="$(sudo docker service ls --filter name=$1 --format \"{{.Replicas}}\")"

#Remove quotes suffix and prefix
clean=$(echo "$result" | sed -e 's/^"//' -e 's/"$//')

#Split the replica values into 
IFS="/" read -a values <<< $clean
running=$(echo "${values[0]}")
quorum=$(echo "${values[1]}")
#echo "Running: $running , Quorum: $quorum"

# Quorum fully running
if [[ running = quorum ]]; then
    echo "Message.Status: up"    
    exit 0;
# None is runnong at all
elif [[ running = 0 ]]; then
    echo "Message.Status: down"
    exit 1;
# Only part of the quorum is running. This condition needs to be checked last.
elif [[ running < quorum ]]; then
    echo "Message.Status: partial"
    exit 2;
fi
