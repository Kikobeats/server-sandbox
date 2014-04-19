#!/bin/bash
echo " * Installing HTTP..."
apt-get -y install apache2 php5

echo " * Configuring local file..."

DIRNAME=$(dirname "$0")
DIR="$DIRNAME"

cp "$DIR"/httpd.conf /etc/apache2/httpd.conf
cp "$DIR"/apache2.conf /etc/apache2/apache2.conf
cp "$DIR"/ports.conf /etc/apache2/ports.conf