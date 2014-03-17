# removing LDAP
apt-get purge slapd ldap-utils;
rm –r /var/lib/ldap;

# remove bind9
apt-get purge bind9
rm -rf /var/cache/bind9 /usr/share/bind9 /etc/bind