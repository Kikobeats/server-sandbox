#!/bin/bash

help(){
  echo " Use: $0 <client/server>"
}

[ "$(id -u)" != "0" ] && echo " Error. This script must be run as root" 1>&2 && exit 1
[ $# != 1 ] && help && exit 1
[ "$1" != "client" -a "$1" != "server" ] && help && exit 2

. "$PWD"/settings.sh
SERVICES="$PWD/Services"

# client and server setup
while [ "$answer" != "yes" -a "$answer" != "no" ]; do
  read -p " Can you configure DNS? [yes/no]: " answer
done
if [ "$answer" = "yes" ] ; then
  . "$SERVICES"/DNS/"$1".sh
fi

unset answer
while [ "$answer" != "yes" -a "$answer" != "no" ]; do
  read -p " Can you configure LDAP? [yes/no]: " answer
done
if [ "$answer" = "yes" ] ; then
  sh "$SERVICES"/LDAP/"$1".sh
fi

unset answer
while [ "$answer" != "yes" -a "$answer" != "no" ]; do
  read -p " Can you configure SSH? [yes/no]: " answer
done
if [ "$answer" = "yes" ] ; then
  sh "$SERVICES"/SSH/"$1".sh
fi

# Only server setup
unset answer
if [ "$1" = "server" ]; then

  while [ "$answer" != "yes" -a "$answer" != "no" ]; do
    read -p " Can you configure SMTP? [yes/no]: " answer
  done
  if [ "$answer" = "yes" ] ; then
    . "$SERVICES"/Mail/smtp.sh
  fi

  unset answer
  while [ "$answer" != "yes" -a "$answer" != "no" ]; do
    read -p " Can you configure POP3? [yes/no]: " answer
  done
  if [ "$answer" = "yes" ] ; then
    . "$SERVICES"/Mail/pop.sh
  fi

  unset answer
  while [ "$answer" != "yes" -a "$answer" != "no" ]; do
    read -p " Can you configure HTTP? [yes/no]: " answer
  done
  if [ "$answer" = "yes" ] ; then
    sh "$SERVICES"/HTTP/"$1".sh
  fi

  echo " Restarting services..."
  . "$PWD"/restart.sh
fi