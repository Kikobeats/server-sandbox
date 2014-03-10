echo " Installing bind9..."
apt-get install bind9

echo "Configuring local file..."
echo "zone \"$DNS_NAME.\" IN {
 type master;
 file \"/etc/bind/db.$DNS_NAME.zone\";
};
" > /etc/bind/named.conf.local

echo "Configuring local optiosn..."
echo "
  options {
  directory \"/var/cache/bind\";
  //dnssec-validation auto;
  auth-nxdomain no;          # conform to RFC1035
  listen-on-v6 { any; };
  };

  forwarders {
    155.54.1.10;             # UM DNS
  };
" > /etc/bind/named.conf.options

echo "Configuring zone file..."
echo "
;
; BIND data file for local loopback interface
;
\$TTL  604800
@ IN  SOA ns.$DNS_NAME. root.ns.$DNS_NAME. (
            1   ; Serial
       604800   ; Refresh
        86400   ; Retry
      2419200   ; Expire
       604800 ) ; Negative Cache TTL
;
@      IN  NS    ns.$DNS_NAME.
ns     IN  A     $PRIMARY_DNS
smtp   IN  A     $PRIMARY_DNS
pop    IN  A     $PRIMARY_DNS
www    IN  CNAME $DNS_NAME.
" > /etc/bind/db.$DNS_NAME.zone

echo "Restart service..."
/etc/init.d/bind9 restart