# 9. Most use commands

## General

`netstat -a | more` # show ports and services that you are using.

## DNS

* `dig www.domain.com` # do DNS query
* `host www.domain.com` # know the IP of a name
* `nslookup www.domain.com` # check if DNS is resolve correctly 

## SMTP

* `telnet xxx.xxx.xxx.xxx 25` # basic query to SMTP service

## POP

* `telnet xxx.xxx.xxx.xxx 110` # basic query to POP service

## LDAP

* `ldapsearch -x -H ldap://LDAP_IP -b "cn='',ou='',o='',c=''" FIELD` # Search in the LDAP IP

## HTTP

*  `curl www.domain.com` # get HTTP source code of a domain

## SSL

* `openssl version -d` # report your SSL directory
* `openssl req -x509 -newkey rsa:2048 -keyout cakey.pem -days 3650 -out cacert.pem` # generate CA autosign in the server* `openssl x509 -in cacert.perm -text` # Check that your server certificate is standard by x509* `openssl rsa -in cakey.perm -text` # Cehck taht your server certificate is RSA correct* `openssl req -new -nodes -newkey rsa:1024 -keyout serverkey.pem -out servercsr.pem` # Generate certificate client* `openssl ca –keyfile cakey.pem -in servercsr.pem -out servercert.pem` # Sign certificate client by the server* `openssl s_server -cert servercert.pem -key serverkey.pem -www` # Check that your client certificate is valid
