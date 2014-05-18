remove_SMTP() {
  echo " * Removing Packages..."
  sudo apt-get -y purge exim4
}

remove_POP() {
  echo " * Removing Packages..."
  sudo apt-get -y purge dovecot-pop3d
}

remove_DNS() {
  echo " * Removing Packages..."
  sudo apt-get -y purge bind9
  echo " * Removing folders..."
  sudo rm -rf /var/cache/bind9 /usr/share/bind9 /etc/bind
}

remove_LDAP() {
  echo " * Removing Packages..."
  sudo apt-get -y purge slapd ldap-utils
  echo " * Removing folders..."
  sudo rm -rf f /etc/apache2/
}

remove_HTTP() {
  echo " * Removing Packages..."
  sudo apt-get -y purge apache2 apache2.2-common php5
  echo " * Removing folders..."
  sudo rm -rf f /etc/apache2/
}

remove_SSH() {
  echo " * Removing Packages..."
  apt-get -y purge openssh-server
  apt-get -y purge openssh-client
}

remove_all() {
  remove_SMTP
  remove_POP
  remove_DNS
  remove_LDAP
  remove_HTTP
  remove_SSH
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

  unset answer
  while [ "$answer" != "yes" -a "$answer" != "no" ]; do
    read -p " Remove SSH? [yes/no]: " answer
  done

  [ "$answer" = "yes" ] && remove_SSH

fi

echo " * Removing temporals files..."
sudo apt-get autoremove