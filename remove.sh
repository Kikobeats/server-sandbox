remove_SMTP() {
  apt-get -y purge exim4
}

remove_POP() {
  apt-get -y purge dovecot-pop3d
}

remove_DNS() {
  apt-get -y purge bind9
  rm -rf /var/cache/bind9 /usr/share/bind9 /etc/bind
}

remove_LDAP() {
  apt-get -y purge slapd ldap-utils
  rm -rf /var/lib/ldap/
}

remove_HTTP() {
  apt-get -y purge apache2 php5
  rm -rf f /etc/apache2/
}

remove_all() {
  remove_SMTP
  remove_POP
  remove_DNS
  remove_LDAP
  remove_HTTP
}

[ "$(id -u)" != "0" ] && echo " Error. This script must be run as root" 1>&2 && exit 1

ALL=$1

if [ "$ALL" = "yes" ]; then

  remove_all

else

  while [ "$answer" != "yes" -a "$answer" != "no" ]; do
    read -p " Remove SMTP? [yes/no]: " answer
  done

  [ "$answer" = "yes" ] && remove_SMTP

  unset answer
  while [ "$answer" != "yes" -a "$answer" != "no" ]; do
    read -p " Remove POP? [yes/no]: " answer
  done

  [ "$answer" = "yes" ] && remove_POP

  unset answer
  while [ "$answer" != "yes" -a "$answer" != "no" ]; do
    read -p " Remove DNS? [yes/no]: " answer
  done

  [ "$answer" = "yes" ] && remove_DNS

  unset answer
  while [ "$answer" != "yes" -a "$answer" != "no" ]; do
    read -p " Remove LDAP? [yes/no]: " answer
  done

  [ "$answer" = "yes" ] && remove_LDAP

  unset answer
  while [ "$answer" != "yes" -a "$answer" != "no" ]; do
    read -p " Remove HTTP? [yes/no]: " answer
  done

  [ "$answer" = "yes" ] && remove_HTTP

fi

apt-get autoremove