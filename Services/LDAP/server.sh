#!/bin/bash

DIRNAME=$(dirname "$0")
DIR="$DIRNAME"

echo " * Installing LDAP..."
apt-get -y install slapd ldap-utils

echo " * Adding LDAP database..."
# Load database type
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f "$DIR"/loadDBD.ldif;

echo " * Loading LDAP example schema..."
# Load database models schema
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/inetorgperson.ldif;
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/cosine.ldif;

echo " * Adding LDAP custom schema ..."
# Load own object for schema
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f "$DIR"/stSchema.ldif;

echo " * Configuring LDAP database..."
# Load database permissions and options
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f "$DIR"/confDatabase.ldif;

echo " * Inserting LDAP data..."
# Load data for the example
sudo ldapmodify -D "cn=admin,o=um,c=es" -W -H ldap:/// -f "$DIR"/st.ldif;
