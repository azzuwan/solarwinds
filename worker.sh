#! /usr/bin/bash
#------------------------------------------------------------------------------------
# Name: worker.sh
# Author: Azzuwan Aziz
# Created: 12/10/2020
# Email: azzuwan.aziz@pccw.com
#------------------------------------------------------------------------------------
# Description:
# This script will query a list of worker nodes ( and registry) and filter it down to the
# particular service name specified from the command arguments. It will then get the
# status value from the STATUS column of the filtered line and perform substring check.
# ------------------------------------------------------------------------------------
# Usage : worker.sh named_instance
#-------------------------------------------------------------------------------------

#check for arguments
if [ $# -eq 0 ]
  then
      echo "Statistic.Status: -1"
      echo "Message.Status No argument supplied to the script"     
      exit 7;
fi

#Filter the service list with a name matching the script argument
result="$(docker ps --format \"{{.Status}}\" --filter name=$1)"
echo $result

if test -z "$result"
    then
        echo "Statistic.Status: -1"
        echo "Message.Status: Script monitor has empty result"
        exit 1;
fi

if [[ "$result" == *"Up"* ]]; then
    day=$(cut -f2 -d" " <<<  $result)
    echo "Statistic.Status: $day "
    echo "Message.Status: $1 is up - $result"
    exit 0;
else
    echo "Statistic.Status: -1"
    echo "Message.Status: $1 is down"
    exit 1;
fi
