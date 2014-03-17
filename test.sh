#!/bin/bash

help(){
  echo " Use: $0 <client/server>"
}

test_ping(){
  ping -q -c5 $1 2&>1 /dev/null
}

show_status(){
  if [ $? -eq 0 ]
  then
    echo "OK"
  else
    echo "Fail"
  fi
}

. $PWD/settings.sh
[ $# != 1 ] && help && exit 1
[ $1 != "client" -a $1 != "server" ] && help && exit 2

### MAIN
## Client Test
if [ $1 = "client" ]; then

  echo " [ PING ] "
  echo -n " * Connectivity Primary DNS Private Cloud..."
  test_ping $PRIMARY_DNS
  show_status

  echo -n " * Connectivity Secundary DNS Private Cloud..."
  test_ping $SECUNDARY_DNS
  show_status

  echo -n " * Connectivity Primary DNS Nameserver..."
  test_ping ns1.st.um
  show_status

  echo -n " * Connectivity Secundary DNS Nameserver..."
  test_ping ns2.st.um
  show_status


## Server Test
else
  echo " [ BIND Check Files ] "
  named-checkconf
  named-checkzone /var/cache/bind/db.$DNS_NAME.zone


## finish
fi

# answer_testmail="undefined"
# answer_testldap="undefined"

# ## Test mail creating server users
# while [ $answer_testmail != "yes" -a $answer_testmail != "no" ]; do
#   read -p " Create test users for mail? [yes/no]: " answer_testmail
# done
# if [ $answer_testmail = "yes" ] ; then
#   echo " * Creating usuario1..."
#   useradd usuario1 -m
#   passwd usuario1

#   echo " * Creating usuario2..."
#   useradd usuario2 -m
#   passwd usuario2
# fi

# ## Test LDAP
# while [ $answer_testldap != "yes" -a $answer_testldap != "no" ]; do
#   read -p " Test LDAP? [yes/no]: " answer_testldap
# done
# if [ $answer_testldap = "yes" ] ; then
#   ldapsearch -Y EXTERNAL -H ldapi:/// -b "cn=config" olcRootDN olcRootPW

# fi