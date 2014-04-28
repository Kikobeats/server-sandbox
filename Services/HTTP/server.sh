#!/bin/bash

DIR="$(dirname "$0")"

APACHE="$DIR/apache2"
VHOST="$DIR/example/vhost"
SITES="$DIR/example/sites"
DEMOCA="$DIR/example/demoCA"
OPENSSL="$DIR/openssl.cnf"
GROUPS="$DIR/groups"

echo " * Installing HTTP..."
sudo apt-get -y install apache2 php5
sudo apt-get install --reinstall apache2.2-common

echo " * Configuring local file..."
cp -r "$APACHE" /etc/apache2

echo " * Activating SSL..."
a2enmod ssl
cp "$OPENSSL" /etc/ssl
cp -r "$DEMOCA" /home/alumno

echo " * Creating local environment..."
cp -r "$VHOST"/* /etc/apache2/sites-available
cp -r "$SITES"/* /var/www/
cp -R "$GROUPS" /etc/apache2/groups

echo "Password for admin @ www.site2.um"
htpasswd -c /etc/apache2/passwords admin

a2ensite site1
a2ensite site2