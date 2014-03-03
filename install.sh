#!/bin/bash

help(){
  echo " Use: $0 <client/server>"
}

## MAIN

[ $# != 1 ] && help && exit 1
[ $1 != "client" -a $1 != "server" ] && help && exit 2

sudo -v
. $PWD/settings.sh
clear

echo " ###############"
echo " # FREE-SERVER #"
echo " ###############"
echo ""

answer="undefined"
while [ $answer != "yes" -a $answer != "no" ]; do
  read -p " Can you configure DNS? [yes/no]: " answer
done
if [ $answer = "yes" ] ; then
  . $PWD/DNS/$1.sh
fi


# # primary dependencies
# # sudo apt-get update
# # sudo apt-get install build-essential
# # VERSION=`uname -r`
# # sudo apt-get install linux-headers-$VERSION

# # # DNS
# # sudo apt-get install bind9
# # service bind9 start

# # # Enjoy
# # reboot


