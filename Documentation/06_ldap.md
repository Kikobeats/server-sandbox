# 6. LDAP

Maybe at this moment you don't know what is a LDAP but maybe use LDAP in the real life.

LDAP *(Lightweight Directory Protocol)* concept is similar to use a address book to annotate information about people around you: Adress, email, work mobile,...

As Internet, LDAP is your adress book. And you can use LDAP for this. Your Adress book online!

LDAP is like database, but is specially designed for queries and put public information about employees of an organization or similar.

LDAP also defines:

* **Permissions**, set by the administrator to allow only certain people to access the LDAP database, and optionally keep certain data private.
* **Schema**: a way to describe the format and attributes of data in the server. For example: a schema entered in an LDAP server might define a "groovyPerson" entry type, which has attributes of "instantMessageAddress", and "coffeeRoastPreference". The normal attributes of name, email address, etc., would be inherited from one of the standard schemas, which are rooted in X.500 (see below).

![](img/ldap-node.png)


## 6.1 Information

| Description  | Service
| -------------	|:-------------
| Aplication	|	LDAP
| Transport		|	TCP/UDP
| Network		|   IPv4/IPv6
| Ports			|	389 (TCP/UDP)


## 6.2 Mount your LDAP
### 6.2.1 Your LDAP in the client

For search in the LDAP client need to install **ldap-utils** command. Later We can configure your typical mail client (Thunderbild, for example) to search in the LDAP when you need a compose a mail and need to know the destination account.

### 6.2.2 Your LDAP in the server

In the server need to install **slapd** service configue the database schema and insert sample data. In this case we have the defintions of the data and the information in the `Services/LDAP/*.dif` files and use `Services/LDAP/server.sh` for boostrapping process. This is set up when you choice install LDAP:

```
echo " * Installing LDAP..."
apt-get -y install slapd ldap-utils

echo " * Adding LDAP database..."
# Load database
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f "$DIR"/loadDBD.ldif;

echo " * Loading LDAP example schema..."
# Load database models schema
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/inetorgperson.ldif;
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/cosine.ldif;

echo " * Adding LDAP custom schema ..."
# Load own schema for the example
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f "$DIR"/stSchema.ldif;

echo " * Configuring LDAP database..."
# Load database configuration
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f "$DIR"/confDatabase.ldif;

echo " * Inserting LDAP data..."
# Insert fake data for the example
sudo ldapmodify -D "cn=admin,o=um,c=es" -W -H ldap:/// -f "$DIR"/st.ldif;
```


## 6.3 Check connectivity

![](img/ldap-search.png)

## 6.4 How LDAP works

Resume:

![](img/ldap-resume.png)


1) BindRequest (Authentication)

![](img/ldap-1.png)

2) BindResponse

![](img/ldap-2.png)

3) SearchRequest

![](img/ldap-3.png)

4) SearchResponse

![](img/ldap-4.png)

5) SearchDone

![](img/ldap-5.png)

6) unbinRequest

![](img/ldap-6.png)
