#!/bin/bash

help(){
  echo " Use: $0 <client/server>"
}

welcome(){
  clear
  echo "                                 __           "
  echo "                                / _|          "
  echo " ___  ___ _ ____   _____ _ __  | |_ ___  _ __ "
  echo "/ __|/ _ \ '__\ \ / / _ \ '__| |  _/ _ \| '__|"
  echo "\__ \  __/ |   \ V /  __/ |    | || (_) | |   "
  echo "|___/\___|_|    \_/ \___|_|    |_| \___/|_|   "
  echo "     _                           _            "
  echo "    | |                         (_)           "
  echo "  __| |_   _ _ __ ___  _ __ ___  _  ___  ___  "
  echo " / _\` | | | | '_ \` _ \| '_ \` _ \| |/ _ \/ __| "
  echo "| (_| | |_| | | | | | | | | | | | |  __/\__ \ "
  echo " \__,_|\__,_|_| |_| |_|_| |_| |_|_|\___||___/ "
  echo
}

[ "$(id -u)" != "0" ] && echo " Error. This script must be run as root" 1>&2 && exit 1
[ $# != 1 ] && help && exit 1
[ $1 != "client" -a $1 != "server" ] && help && exit 2

. $PWD/settings.sh
SERVICES="$PWD/Services"
welcome
answer="undefined"

### MAIN
# client and server setup
while [ $answer != "yes" -a $answer != "no" ]; do
  read -p " Can you configure DNS? [yes/no]: " answer
done
if [ $answer = "yes" ] ; then
  . $SERVICES/DNS/$1.sh
fi

answer="undefined"
while [ $answer != "yes" -a $answer != "no" ]; do
  read -p " Can you configure LDAP? [yes/no]: " answer
done
if [ $answer = "yes" ] ; then
  sh $SERVICES/LDAP/$1.sh
fi

# Only server setup
if [ $1 = "server" ]; then

  while [ $answer != "yes" -a $answer != "no" ]; do
    read -p " Can you configure SMTP? [yes/no]: " answer
  done
  if [ $answer = "yes" ] ; then
    . $SERVICES/Mail/smtp.sh
  fi

  while [ $answer != "yes" -a $answer != "no" ]; do
    read -p " Can you configure POP3? [yes/no]: " answer
  done
  if [ $answer = "yes" ] ; then
    . $SERVICES/Mail/pop.sh
  fi

  echo " Restarting services..."
  . $PWD/Services/restart.sh

  echo " Finish! Good day (night)"
fi