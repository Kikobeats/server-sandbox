#!/bin/bash

help(){
  echo " Use: $0 <client/server>"
}

## MAIN

[ $# != 1 ] && help && exit 1
[ $1 != "client" -a $1 != "server" ] && help && exit 2

sudo -v
. $PWD/settings.sh
SERVICES="$PWD/Services"
clear

echo " ###############"
echo " # FREE-SERVER #"
echo " ###############"
echo ""

answer_dns="undefined"
while [ $answer_dns != "yes" -a $answer_dns != "no" ]; do
  read -p " Can you configure DNS? [yes/no]: " answer_dns
done
if [ $answer_dns = "yes" ] ; then
  . $SERVICES/DNS/$1.sh
fi

if [ $1 = "server" ]; then

  answer_smtp="undefined"
  while [ $answer_smtp != "yes" -a $answer_smtp != "no" ]; do
    read -p " Can you configure SMTP? [yes/no]: " answer_smtp
  done
  if [ $answer_smtp = "yes" ] ; then
    . $SERVICES/Mail/smtp.sh
  fi

  answer_pop="undefined"
  while [ $answer_pop != "yes" -a $answer_pop != "no" ]; do
    read -p " Can you configure POP3? [yes/no]: " answer_pop
  done
  if [ $answer_pop = "yes" ] ; then
    . $SERVICES/Mail/pop.sh
  fi

  echo " Restarting services..."
  . $PWD/Services/restart-services.sh

  echo " Finish! Good day (night)"

fi
