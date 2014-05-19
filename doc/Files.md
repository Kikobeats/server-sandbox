# Important Files

## DNS

* `/etc/resolv.conf`
* `/etc/bind/named.conf.options`
* `/etc/bind/named.conf.local`
* `/etc/bind/db."$DNS_NAME".zone`

# Important commands

## DNS

* dig `www.domain.com` # do DNS query
* host `www.domain.com` # know the IP of a name
* nslookup `www.domain.com` # check if DNS is resolve correctly 