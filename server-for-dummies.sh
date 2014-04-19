#!/bin/bash

welcome(){
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

finish() {
  read -p " $1 finished. Press any key to continue...."
  clear
}

menu(){
  welcome
  while [ "$opt" != 0 ]; do
   echo " 1. Install Services"
   echo " 2. Remove Services"
   echo " 3. Restart Services"
   echo " 4. Test Services"
   echo " 0. Exit"
   read -p " : " opt
   case $opt in
    1)
      while [ "$answer" != "client" -a "$answer" != "server" ]; do
        read -p " client or server? [client/server]: " answer
      done
      sh "$PWD"/install.sh "$answer" && finish "Install";;
    2)
      while [ "$answer" != "yes" -a "$answer" != "no" ]; do
        read -p " All services? [yes/no]: " answer
      done
      sh "$PWD"/remove.sh "$answer" && finish "Remove";;
    3)
      sh "$PWD"/restart.sh && finish "Restart";;
    4)
      while [ "$answer" != "client" -a "$answer" != "server" ]; do
        read -p " client or server? [client/server]: " answer
      done
      sh "$PWD"/test.sh "$answer" && finish "Test";;
    0)
      echo " Good day (night)" && exit 0;;
    *) welcome
   esac
   welcome
  done
}

[ "$(id -u)" != "0" ] && echo " Error. This script must be run as root" 1>&2 && exit 1
clear && menu