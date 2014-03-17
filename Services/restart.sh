#!/bin/bash

service exim4 restart   # SMTP
service dovecot restart # POP
service bind9 restart   # DNS
service slapd restart   # LDAP

echo " ...done"
