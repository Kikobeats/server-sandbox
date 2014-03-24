[ "$(id -u)" != "0" ] && echo " Error. This script must be run as root" 1>&2 && exit 1

# SMTP
# POP
# DNS
apt-get purge bind9
rm -rf /var/cache/bind9 /usr/share/bind9 /etc/bind
# LDAP
apt-get purge slapd ldap-utils
rm -rf /var/lib/ldap/

# finish
apt-get autoremove
echo " ...done"