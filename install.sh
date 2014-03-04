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

answer="undefined"
while [ $answer != "yes" -a $answer != "no" ]; do
  read -p " Can you configure DNS? [yes/no]: " answer
done
if [ $answer = "yes" ] ; then
  . $SERVICES/DNS/$1.sh
fi

if [ $1 = "server" ]; then

  answer="undefined"
  while [ $answer != "yes" -a $answer != "no" ]; do
    read -p " Can you configure SMTP? [yes/no]: " answer
  done
  if [ $answer = "yes" ] ; then
    . $SERVICES/Mail/smtp.sh
  fi

  answer="undefined"
  while [ $answer != "yes" -a $answer != "no" ]; do
    read -p " Can you configure POP3? [yes/no]: " answer
  done
  if [ $answer = "yes" ] ; then
    . $SERVICES/Mail/pop.sh
  fi

fi
