echo " * Installing DNS..."
apt-get install bind9

while [ $asnwer_dns_type != "primary" -a $asnwer_dns_type != "secundary" ]; do
  read -p " Can you configure DNS? [primary/secundary]: " asnwer_dns_type
done
if [ $asnwer_dns_type = "primary" ] ; then

  # PRIMARY DNS CONFIG
  echo " * Configuring local file..."
  echo "zone \"$DNS_NAME.\" IN {
   type master;
   file \"/etc/bind/db.$DNS_NAME.zone\";
   allow-transfer {$SECUNDARY_DNS;};
  };
  " > /etc/bind/named.conf.local

  echo " * Configuring local options..."
  echo "
    options {
    directory \"/var/cache/bind\";
    //dnssec-validation auto;
    auth-nxdomain no;          # conform to RFC1035
    listen-on-v6 { any; };
    forwarders {$FORWARDERS}; # UM DNS
  };
  " > /etc/bind/named.conf.options

  echo " * Configuring zone file..."
  echo "
  ;
  ; BIND data file for local loopback interface
  ;
  \$TTL  604800
  @ IN  SOA ns1.$DNS_NAME. root.ns1.$DNS_NAME. (
              1   ; Serial
         604800   ; Refresh
          86400   ; Retry
        2419200   ; Expire
         604800 ) ; Negative Cache TTL
  ;
  @      IN  NS    ns1.$DNS_NAME.
  @      IN  NS    ns2.$DNS_NAME.
  ns1    IN  A     $PRIMARY_DNS
  ns2    IN  A     $SECUNDARY_DNS
  smtp   IN  A     $PRIMARY_DNS
  pop    IN  A     $PRIMARY_DNS
  ldap   IN  A     $PRIMARY_DNS
  www    IN  CNAME $DNS_NAME
  " > /etc/bind/db.$DNS_NAME.zone

else

  # SECUNDARY DNS CONFIG
  echo " * Configuring local file..."
  echo "zone \"$DNS_NAME.\" IN {
   type slave;
   file \"/etc/bind/db.$DNS_NAME.zone\";
   masters {$PRIMARY_DNS;};
  };
  " > /etc/bind/named.conf.local

fi