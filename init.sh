#!/bin/bash

reset(){
  welcome_init
  unset answer
}

welcome_init(){
  echo "                                 __               "
  echo "                                / _|              "
  echo " ___  ___ _ ____   _____ _ __  | |_ ___  _ __     "
  echo "/ __|/ _ \ '__\ \ / / _ \ '__| |  _/ _ \| '__|    "
  echo "\__ \  __/ |   \ V /  __/ |    | || (_) | |       "
  echo "|___/\___|_|    \_/ \___|_|    |_| \___/|_|       "
  echo "     _                           _                "
  echo "    | |                         (_)               "
  echo "  __| |_   _ _ __ ___  _ __ ___  _  ___  ___      "
  echo " / _\` | | | | '_ \` _ \| '_ \` _ \| |/ _ \/ __|  "
  echo "| (_| | |_| | | | | | | | | | | | |  __/\__ \     "
  echo " \__,_|\__,_|_| |_| |_|_| |_| |_|_|\___||___/     "
  echo "                                                  "
  echo "       Warn: check 'settings' file first!         "
  echo "                                                  "

}

welcome_install() {
  clear
  echo " _           _        _ _ "
  echo "(_)         | |      | | |"
  echo " _ _ __  ___| |_ __ _| | |"
  echo "| | '_ \/ __| __/ _\` | | |"
  echo "| | | | \__ \ || (_| | | |"
  echo "|_|_| |_|___/\__\__,_|_|_|"
  echo ""
}

welcome_uninstall() {
  clear
  echo "             _           _        _ _ "
  echo "            (_)         | |      | | |"
  echo " _   _ _ __  _ _ __  ___| |_ __ _| | |"
  echo "| | | | '_ \| | '_ \/ __| __/ _\` | | |"
  echo "| |_| | | | | | | | \__ \ || (_| | | |"
  echo " \__,_|_| |_|_|_| |_|___/\__\__,_|_|_|"
  echo ""
}

welcome_test() {
  clear
  echo " _            _   _             "
  echo "| |          | | (_)            "
  echo "| |_ ___  ___| |_ _ _ __   __ _ "
  echo "| __/ _ \/ __| __| | '_ \ / _\` |"
  echo "| ||  __/\__ \ |_| | | | | (_| |"
  echo " \__\___||___/\__|_|_| |_|\__, |"
  echo "                           __/ |"
  echo "                          |___/"
  echo ""
}

welcome_restart(){
  clear
  echo "               _             _   "
  echo "              | |           | |  "
  echo " _ __ ___  ___| |_ __ _ _ __| |_ "
  echo "| '__/ _ \/ __| __/ _\` | '__| __|"
  echo "| | |  __/\__ \ || (_| | |  | |_ "
  echo "|_|  \___||___/\__\__,_|_|   \__|"
  echo ""
}

finish() {
  echo ""
  read -p " $1 finished. Press any key to continue..." null
  clear
}

menu(){
  reset
  while [ "$opt" != 0 ]; do
   echo " 1. Install Services"
   echo " 2. Uninstall Services"
   echo " 3. Restart Services"
   echo " 4. Test Services"
   echo " 0. Exit"
   read -p " : " opt
   case $opt in

    1)
      welcome_install
      while [ "$answer" != "client" -a "$answer" != "server" ]; do
        read -p " client or server? [client/server]: " answer
      done
      sh "$PWD"/install.sh "$answer" && finish "Install";;
    2)
      welcome_uninstall
      while [ "$answer" != "yes" -a "$answer" != "no" ]; do
        read -p " All services? [yes/no]: " answer
      done
      sh "$PWD"/uninstall.sh "$answer" && finish "Uninstall";;
    3)
      welcome_restart
      sh "$PWD"/restart.sh && finish "Restart";;
    4)
      welcome_test
      while [ "$answer" != "client" -a "$answer" != "server" ]; do
        read -p " client or server? [client/server]: " answer
      done
      sh "$PWD"/test.sh "$answer" && finish "Test";;
    0)
      echo " Good day (night)" && exit 0;;
    *) reset

   esac
   reset
  done
}

[ "$(id -u)" != "0" ] && echo " Error. This script must be run as root" 1>&2 && exit 1
clear && menu