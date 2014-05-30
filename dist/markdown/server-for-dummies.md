
# 1. Get Started

<img src="img/cover.jpg" alt="" style="width: 50%;">


![](https://api.travis-ci.org/Kikobeats/server-for-dummies.png)
![](http://imgur.com/7Xir0aL.png)

[Online](http://server-dummies.herokuapp.com) | [EPUB](https://github.com/Kikobeats/server-for-dummies/raw/master/dist/epub/server-for-dummies.epub) | [MOBI](https://github.com/Kikobeats/server-for-dummies/raw/master/dist/epub/server-for-dummies.mobi) | [PDF](https://github.com/Kikobeats/server-for-dummies/raw/master/dist/pdf/server-for-dummies.pdf) | [Github](https://github.com/Kikobeats/server-for-dummies)

`server for dummies` is an educational project to understand how typical web services work. It's focused in the application layout services, like:

  | Services                     | Transport | Port                                                     | Package
  |                              |           |                                                          | 
  | DNS (Primary and secundary)  | TCP/UDP   | 53/UDP <br/> 53/TCP                                      | bind9
  | SMTP                         | TCP       | 25/TCP <br/> 587/TCP (alternative) <br/> 465/TCP (SMTPS) | exim4
  | POP3                         | TCP       | 110/TCP <br/> 995/TCP (encrypted)                        | dovecot-pop3
  | IMAP                         | TCP       | 143/TCP <br/> 220/TCP (IMAP3) <br/> 993/TCP (IMAPS)      | soon
  | LDAP                         | TCP/UDP   | 389 (TCP/UDP)                                            | slapd <br/> ldap-utils
  | HTTP/HTTPS                   | TCP       | 80                                                       | apache2 <br/> php5
  | SSH                          | TCP       | 21                                                       | openssh
  | FTP                          | TCP       | 20/TCP DATA Port <br/> 21/TCP Control Port               | soon
  | IPSEC                        |           |                                                          | soon
  | TELNET                       | TCP       | 23                                                       | soon
  | DHCP                         | UDP       | 67 (server) <br/>68 (client)                             | soon

For installing all services and get ready your machine for the action, this project has a repository with the original source coude and it is available for everyone.

Have fun!

**NOTE:** This is only a educational example. Don't use in production.

## 1.1. How to use

1) Clone the repo:

`git clone https://github.com/Kikobeats/server-for-dummies.git`

2) go to folder `server-for-dummies` and edit `settings.sh` with your options:

```
## DNS Settings
DNS_NAME="st.um" 
PRIMARY_DNS="172.16.22.135"
SECONDARY_DNS="172.16.22.137"
FORWARDERS="155.54.1.10;"

## SMTP Settings
LOCAL_NETWORK="172.16.22.0/24"
RELAY_DOMAINS="$DNS_NAME; um.es"

## OPENSSL Settings
USERNAME="josefranciscoverdugambin"
```

3) Run it with admin account!

`sudo sh init.sh`

![](img/readme-main.png)
	
## 1.2. Test services

All services have been tested in VM VMWare under Ubuntu Server 12.04:

* VM 1 – Main client
* VM 2 – Primary DNS
* VM 3 – Secondary DNS

For test services connectivity run 'Test services'

![](img/readme-testing.png)


# 1.3. Examples

Include:

* 3 example of domains
	* www1.st.um – Basic domain
	* www2.st.um – Domain with HTTP authentication ([authorized users here](https://github.com/Kikobeats/server-for-dummies/blob/master/Services/HTTP/groups))
	* www3.st.um – Domain with HTTPS (check you are visiting https in the browser!)
	
* 2 mails accounts examples
	* run `./Services/Mail/account.sh` to create it at first time 
	
* LDAP 
	* Sample data for check read and modify operations ([check here](https://github.com/Kikobeats/server-for-dummies/tree/master/Services/LDAP))	 
	
**Example SSL**

![](img/readme-https.png)

**Example Mails** 

![](img/readme-mail.png)

**Example SSH**

![](img/readme-ssh.png)

# 2. Understand

Internet is the best invent in the last 50 years, and maybe someone can say that is the best invention in the world.

First, relax. Internet is not perfect and needs much human value to make it a secure service for daily things, for example, reading your mail, visiting a cats' website, downloading creative commons music and films...

Internet is nested in layers called [OSI model](https://en.wikipedia.org/wiki/OSI_model). Seven layers compound the OSI model and each layer offers services for differents things.

![](img/osi-layers.png)


Top-level layers need their lower layer to offer a service. Your browser doesn't load a website if its transfer protocol doesn't work correctly.

Other important networks elements are routers, switches and host and using different protocols (BGP, RIP, OSPF) to communicate with each one and make internet a network of computers that understands how a package travles from EEUU to Spain.

But this is not important here. You'll need to understand how to set up your machine to be accesible for the others and to offer your services for resolving names, having mails accounts under your domain...

The services that you intend to use belong to the application layer. As I said before, this services use services or protocols of lower layers of the OSI model. For example, DNS is an aplication service, but it needs a transport protocol to resolve name to IP. By the other hand, IP is based on network layer IPv4 (or better, IPv6) to be operative for the application layer.

![](img/dns-works.png)

At the end, all is a stack of abstraction. The purpose is having an application layer available, secure and operative.

Now, is time to take action!

## 2.1. Files

**DNS**

* `/etc/resolv.conf`
* `/etc/bind/named.conf.options`
* `/etc/bind/named.conf.local`
* `/etc/bind/db."$DNS_NAME".zone`

**SMTP**

* `/etc/exim4/update-exim4.conf.conf` # Exim4 settings

**POP**

* `/etc/dovecot/conf.d/10-mail.conf` # Dovecot settings
* `/etc/dovecot/conf.d/10-auth.conf` # Dovecot settings

**LDAP**

* `ldapmodify -Y EXTERNAL -H ldapi:/// -f FILE` # Modify LDAP settings
* `ldapadd -Y EXTERNAL -H ldapi:/// -f FILE` # Load database data

**HTTP**

* `/etc/apache2/sites-available` # Apache virtual hosts
* `/var/www/` # Apache websites data
* `/etc/apache2/groups` # Apache authentication

**SSL**

* `usr/lib/ssl/openssl.cnf` # Configuration file of SSL

**SSH**

* `~/.ssh` # Content SSH keys


## 2.2. Commands

**General**

`netstat -a | more` # show ports and services that you are using.

**DNS**

* `dig www.domain.com` # do DNS query
* `host www.domain.com` # know the IP of a name
* `nslookup www.domain.com` # check if DNS is resolve correctly

**SMTP**

* `telnet xxx.xxx.xxx.xxx 25` # basic query to SMTP service

**POP**

* `telnet xxx.xxx.xxx.xxx 110` # basic query to POP service

**LDAP**

* `ldapsearch -x -H ldap://LDAP_IP -b "cn='',ou='',o='',c=''" FIELD` # Search in the LDAP IP

**HTTP**

*  `curl www.domain.com` # get HTTP source code of a domain

**SSL**

* `openssl version -d` # report your SSL directory
* `openssl req -x509 -newkey rsa:2048 -keyout cakey.pem -days 3650 -out cacert.pem` # generate CA autosign in the server
* `openssl x509 -in cacert.perm -text` # Check that your server certificate is standard by x509
* `openssl rsa -in cakey.perm -text` # Cehck taht your server certificate is RSA correct
* `openssl req -new -nodes -newkey rsa:1024 -keyout serverkey.pem -out servercsr.pem` # Generate certificate client
* `openssl ca –keyfile cakey.pem -in servercsr.pem -out servercert.pem` # Sign certificate client by the server
* `openssl s_server -cert servercert.pem -key serverkey.pem -www` # Check that your client certificate is valid

# 3. DNS

DNS is one of the most important services for internet because is necessary to convert a name of one web in its IP for simply question: Remember a IP is very most difficult that remember a name.

At first for to do it the first computers had a simply file called `host.txt` that works similar to key/value dictionary: One name have one IP translation. And one of this old computers is used to serve the HOSTS.txt updated of the rest of old computers. This is the concept.

![](img/dns-translate.png)

This is simply if you have less than 10 computers in the world. But now, this is a bit complicated with too much computers.

The DNS service is regulated by the [ICANN since 1988](https://en.wikipedia.org/wiki/ICANN).

Basically for understand how ICANN regulated it you must know that she designates a root nodes to keep all information about how to resolve whatever domain. When you go to website to register a website name, actually you are recording your domain in the ICANN nodes.

![](img/dns-organization.png)

Each domain have different **records** for the dommain. A record is the basic data component in DNS. Resource records define not only names and IP addresses but domains, servers, zone, and services as well. This list shows you the most common types of resource records:

<table>
<tbody><tr>
<th>Type</th>
<th>Purpose</th>
</tr>
<tr>
<td><b>A</b></td>
<td><i>Address</i> resource records match an IP address to a host
name.</td>
</tr>
<tr>
<td><b>CNAME</b></td>
<td><i>Canonical name</i> resource records associate a nickname to
a host name.</td>
</tr>
<tr>
<td><b>MX</b></td>
<td><i>Mail exchange</i> resource records identify mail servers for
the specified domain.</td>
</tr>
<tr>
<td><b>NS</b> <b></b></td>
<td><i>Name server</i> resource records identify servers (other
than the SOA server) that contain zone information files.</td>
</tr>
<tr>
<td><b>PTR</b> </td>
<td><i>Pointer resource</i> records match a host name to a given IP
address. This is the opposite of an Address record, which matches
an IP address to the supplied host name.</td>
</tr>
<tr>
<td><b>SOA</b></td>
<td><i>Start of authority</i> resource records specify which server
contains the zone file for a domain.</td>
</tr>
<tr>
<td><b>SRV</b> </td>
<td><i>Service</i> resource records identify servers that provide
special services to the domain.</td>
</tr>
</tbody></table>

When you need to know the IP about a record, you request this at your DNS with a query. The query is recursive request and is completed when DNS found the record of the domain that you need:

![](img/dns-quote.png)

Check typical DNS records [here](https://en.wikipedia.org/wiki/List_of_DNS_record_types).

## 3.1. Mount your own DNS

Only need have set up your service locally and this will connect with ICANN nodes to resolve web adress. And you can resolve custom name locally if you have not bought the domain name.

### 3.1.1. Your DNS in the client

You need to say at your client that use your DNS to resolve names. Run the script and select this options:

```
1. Install Services > client > DNS
```

Now, you have said in your client that use the IP of your server to resolve names. This is in the file `/etc/resolv.conf`:

```
echo " * Configuring DNS client..."
echo "# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
# DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
nameserver $PRIMARY_DNS
nameserver $SECONDARY_DNS
#search localdomain
" > /etc/resolv.conf
```

In my case have two servers for primary and secondary DNS.

### 3.1.2. Your DNS in the server

Server configuration is also simple, but it requires a few extra steps.

```
1. Install Services > client > DNS > [Select primary or secondary]
```

The script do this:


1. Install **bind9**, a application to provide DNS services
2. Edit `/etc/resolv.conf` file and add your own direction
3. Set up **bind9** to define your domain database and your secondary IP if is defined.

```
write_config_local_server(){
echo "zone \"$DNS_NAME.\" IN {
  type master;
  file \"/etc/bind/db.$DNS_NAME.zone\";
  allow-transfer {$SECONDARY_DNS;};
  }; " > /etc/bind/named.conf.local
}
```

4. In the domain database write entries to be resolubles main services that use DNS to access it:

```
write_database(){
echo "\$TTL  604800
@ IN  SOA ns1.$DNS_NAME. root.ns1.$DNS_NAME. (
            1   ; Serial
       604800   ; Refresh
        86400   ; Retry
      2419200   ; Expire
       604800 ) ; Negative Cache TTL

@             IN      NS         ns1.$DNS_NAME.
ns1           IN      A          $PRIMARY_DNS
@             IN      NS         ns2.$DNS_NAME.

ns2           IN      A          $SECONDARY_DNS
$DNS_NAME.    IN      A          $PRIMARY_DNS

smtp          IN      CNAME      $DNS_NAME.
pop3          IN      CNAME      $DNS_NAME.
ldap          IN      CNAME      $DNS_NAME.
www           IN      CNAME      $DNS_NAME.
www1          IN      CNAME      $DNS_NAME.
www2          IN      CNAME      $DNS_NAME.
www3          IN      CNAME      $DNS_NAME.
" > /etc/bind/db."$DNS_NAME".zone
}
```

For the secondary server, the configuration is more easy because this use primary server to get information and don't need too more:

```
write_config_local_client(){
echo "zone \"$DNS_NAME.\" IN {
  type slave;
  file \"/var/cache/bind/db.$DNS_NAME.zone\";
  masters {$PRIMARY_DNS;};
};
" > /etc/bind/named.conf.local
}
```

## 3.2. Check connectivity

You can check connectivity in the client with two commands:

![](img/dns-dig.png)

![](img/dns-look.png)

## 3.3. How DNS works

![](img/dns-header.jpg)

### 3.3.1. Internal query

For the example, I runt `dig st.um` command and see in the wireshark what happens:

The client do standard query connection at default DNS server (my server). In the header I say that I want to transalte `st.um` adress (of type `A`)

![](img/dns-1.png)

The server respond me. In the `answer` entry of the header you can see the IP of my request name, and the adress of the DNS server that serve the information:

![](img/dns-2.png)

### 3.3.2. External query

This process is similar to internal query, but now depend of external DNS.

In this case, I do a `ping google.com` and in this process I need first translate `google.com` name into a IP name:

![](img/dns-3.png)

The DNS server respond me with a list of availables IPs for `google.com` domain:

![](img/dns-4.png)

Now, I can continue with my ping!

# 4. HTTP

HTTP (short for *HyperText Transfer Protocol*) is the underlying protocol used by the World Wide Web. HTTP defines how messages are formatted and transmitted, and what actions Web servers and browsers should take in response to various commands. For example, when you enter a URL in your browser, this actually sends an HTTP command to the Web server directing it to fetch and transmit the requested Web page.

All parameter of the protocol are specified in the **HTTP header**

Client Request:

```
GET /index.html HTTP/1.1
Host: www.example.com
```

Server Response:

```
HTTP/1.1 200 OK
Date: Mon, 23 May 2005 22:38:34 GMT
Server: Apache/1.3.3.7 (Unix) (Red-Hat/Linux)
Last-Modified: Wed, 08 Jan 2003 23:11:55 GMT
ETag: "3f80f-1b6-3e1cb03b"
Content-Type: text/html; charset=UTF-8
Content-Length: 131
Accept-Ranges: bytes
Connection: close

<html>
<head>
  <title>An Example Page</title>
</head>
<body>
  Hello World, this is a very simple HTML document.
</body>
</html>
```


A message in HTTP have 3 parts:

1. First line with *HTTP_Method*, *Resource ID* adn  *HTTP Version*.
2. Information about the client and the petition.
3. Body request if the client need to transfer data to the server.

![image](img/http-format.png)

The HTTP methods are different for different actions:

![](img/http-commands.png)

And each client request is response with status code:

* **1xx** Informational
* **2xx** Success
* **3xx** Redirection
* **4xx** Client Error
* **5xx** Server Error

Special mention to:

```
418 I'm a teapot (RFC 2324)
This code was defined in 1998 as one of the traditional IETF April Fools' jokes, in RFC 2324, Hyper Text Coffee Pot Control Protocol, and is not expected to be implemented by actual HTTP servers.
```

![](img/http-code.png)

## 4.1. Mount your HTTP

### 4.1.1. Your HTTP in the client

If you have a Browser and/or terminal, you don't need additional things.

### 4.1.2. Your HTTP in the server

We use **apache** and **php**.

apache is used to service files and can be resolve in the client. Also, we can configure it to mount differents domains separated but under the same machine.

For do it, first need define **virtual hosts**. In the example we use 3 virtual hosts:

* virtual host to www1.st.um and basic website.
* virtual host to www2.st.um and basic apache authentication.
* virtual host to www3.st.um to get a secure HTTP based on SSL certificate (HTTPS).

This files are defined in `Services/example/` and with the script we go to copy differents files to differents folders:

* We copy the files of the virtual hosts `Services/example/vhost` to `/etc/apache2/sites-available`
* We copy the files of the websites `Services/example/sites` to `/var/www/`
* We copy the files of the apache authentication methd  `Services/example/groups` to `/etc/apache2/groups`


## 4.2. Check connectivity

Run client browser and go to url examples:

1) Basic website:

![](img/http-basic.png)

2) Basic Apache authentication:

![](img/http-login.png)
![](img/http-auth.png)

2) Secure HTTP connection:

![](img/http-s.png)

Alternative you can do it with terminal and you get the source code of the website:

![](img/http-terminal.png)

## 4.3. How HTTP works

![](img/http-works.png)

![](img/http-resume.png)

1) HTTP Request (GET Command)

![](img/http-1.png)

2) HTTP Response (200 OK code status)

![](img/http-2.png)


# 5. SSL

SSL (*Secure Sockets Layer*) is the standard security technology for establishing an encrypted link between a web server and a browser. This link ensures that all data passed between the web server and browsers remain private and integral. SSL is an industry standard and is used by millions of websites in the protection of their online transactions with their customers.

SSL does two things:

1. **Authenticates the server to the client.** (*Handshake*)
2. Encrypts your HTTP session.

We go to explain **Handshake** process:

* Client send `clientHello` message specifying encrypted options: SSL version, compress method,... and sending random numbers that they use later.
* The server receive the message and select:
	* What simetric algorythm (**secret key**) use (e.g. [AES](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard), [3DES](https://en.wikipedia.org/wiki/Triple_DES), [RC5](https://en.wikipedia.org/wiki/RC5)).
	* What asimetric algorythm (**public key**) use (e.g. [RSA](wiki/RSA_(cryptosystem), [Diffie-Hellman](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange)).
	* What MAC algorythm use ([SHA](https://en.wikipedia.org/wiki/Secure_Hash_Algorithm)).


Why select simetric and asimetric algorythm? Why not use only one?

When client finally send data to the server, they use simetric algorythm, but first, to get it, they need to negotiate and exchange confidence information. This proceed is known as **Pre Master Key**.

There are two ways to do Pre Master Key process:

1. With **Diffie-Helman**: Client and server exchange `SERVER_KEY_EXCHANGE` and `CLIENT_KEY_EXCHANGE` and both parts know 	the information to operate with simetric algorythm.

2. With **RSA**: The client catch the public key of the Server Certificate (message `CERTIFICATE`)and encrypted the master key. Only the server can desncrypted this with her private key.

And send to the client `serverHello` with this options, distinctive server number and their certificates to check the identify of the server domain.


But, one moment... Why am I going to trust the server? and if not who he claims to be?

Before Pre Master Key process is necessary for the server to authenticate it, for do it is also necessay asimetric algorythm, normally with RSA. And then, thec MAC algorythm is use to verify that data of the session is authenticathed.

We can resume all the process with two variants of message:

* **TLSv1_RSA_WITH_AES_128_CBC_SHA**
	- **TLSv1**: version of TLS (SSL protocol)
	- **RSA**: For server authentication and pre master key process.
	- **AES**: For simetric algorythm after master key
	- **SHA**: For MAC encryptation

* **TLSv1_DHE_RSA_WITH_AES_256_CBC_SHA**
	- **TLSv1**: version of TLS (SSL protocol)
	- **DHE**: For server authentication based of Diffie-Helman for pre master key.
	- **RSA**: For server authentication.
	- **AES**: For simetric algorythm after master key.
	- **SHA**: For MAC encryptation.

The resume of the process in one image:


![](img/ssl-handshake.png)

The complexities of the SSL protocol remain invisible to your customers. Instead their browsers provide them with a key indicator to let them know they are currently protected by an SSL encrypted session - the lock icon in the lower right-hand corner, clicking on the lock icon displays your SSL Certificate and the details about it. All SSL Certificates are issued to either companies or legally accountable individuals.

## 5.1. Mount your SSL
### 5.1.1. SSL in the client

If the server has done its homework anything is necessary in the client, only have a modern browser and the `*.pem` to load it (see part of SSL in the server).

### 5.1.2. SSL in the server

For have SSL in HTTP known as HTTPS first you need to have HTTP service.

For have HTTPS you need a certificate to expose that your domain is secure and you are your owner.

Now we are to explain how to generate your certificate for do a illustrative example, but in the practice the SSL certificate is created by **Certification Authority** (*CA*) that typically are companies of hosting. Remember this.

The CA establishes a chain of trust between he and domains of users:

![](img/ssl-chain.png)

About what your need in your server we use **openssl** that is typically installed in UNIX systems by default.

The process is divided in two steps: First need to generate the CA autosign for the server and later generate the clien certificate and sign it with serve CA.

Typically an SSL Certificate will contain your domain name, your company name, your address, your city, your state and your country. It will also contain the expiration date of the Certificate and details of the Certification Authority responsible for the issuance of the Certificate. When a browser connects to a secure site it will retrieve the site's SSL Certificate and check that it has not expired, it has been issued by a Certification Authority the browser trusts, and that it is being us.

**CA Certificate in the server**

first need to know OpenSSL directory. In terminal type:

```
openssl version -d
```

And report you the directory, typically `usr/lib/ssl`. Now we need to edit `openssl.cnf` and update this entries with your values. In my case this are my values:

```
....
[ CA_default ]
...
dir = ./demoCA
countryName_default = ES
stateOrProvinceName_default =
0. organizationalName_default = UMU
organizationalUnitName_default = ST
...
```

because my domain is a Spanish domain and the domian for the exmaple is `st@um`.

Now go to adjust options to generate a certificate. in the same file and go to `[ policy_match ]` section and update set `stateOrProvinceName` value to `optional`.

Go to the path of CA_default and create `demoCA` folder with this structure:

```
cd $HOME
mkdir -p demoCA && cd demoCA
mkdir -p newcerts
mkdir -p certs
touch index.txt
echo "00" > clrnumber
echo "01" > serial
```

Now you are ready to generate the certificate. To do it, run the appropriate command:

```
openssl req -x509 -newkey rsa:2048 -keyout cakey.pem -days 3650 -out
cacert.pem
```

You can check that your certificate is correct with this commands:
```
openssl x509 -in cacert.perm -text
openssl rsa -in cakey.perm -text
```

**CA Certificate in the client**

First generate it:

```
openssl req -new -nodes -newkey rsa:1024 -keyout serverkey.pem -out servercsr.pem
```

And later sign it:

```
openssl ca –keyfile cakey.pem -in servercsr.pem -out servercert.pem
```
The certificate on `*.pem` is necessary because is the format that the browser can read the certificate.

You can check that certificate is valid running this command:
```
openssl s_server -cert servercert.pem -key serverkey.pem -CAfile clientcert.pem
```

![](img/ssl-test.png)

## 5.2. Check connectivity

## 5.3. How SSL Works

Resume of the process:

![](img/ssl-handshake.jpg)

Resume of messages:

![](img/ssl-resume.png)

1) Client send `HELLO` message with distinctive random number and information about what compression and Cipher suites support and request to the server the X509 certificate to trust him.

![](img/ssl-1.png)

2) The server receive the message and:

1. Read the `HELLO` message of the client and select the options of the session.
2. Send to the client the Certificate to show that you can trust him.
3. do `SERVER_KEY_EXCHANGE` as part of the process of Pre Master Key

![](img/ssl-2.png)

3) Client receive server message and proceed to:

1. Validate the identity of the server.
2. do `CLIENT_KEY_ECHANGE` as part of the process of Pre Master Key.

at this moment client can be calculate the **Master Key**.

![](img/ssl-3.png)

4) Server receive client message and can calculate **Master Key**. From here both part have a shared secret

![](img/ssl-4.png)

5) The information from here can travel encrypted. Is not posible see the data content

![](img/ssl-5.png)

![](img/ssl-6.png)

![](img/ssl-7.png)

![](img/ssl-8.png)

![](img/ssl-9.png)

# 6. LDAP

Maybe at this moment you don't know what is a LDAP but maybe use LDAP in the real life.

LDAP *(Lightweight Directory Protocol)* concept is similar to use a address book to annotate information about people around you: Adress, email, work mobile,...

As Internet, LDAP is your adress book. And you can use LDAP for this. Your Adress book online!

LDAP is like database, but is specially designed for queries and put public information about employees of an organization or similar. The tree structure of a LDAP is known as **Directory Information Tree** (*DIT*):

![](img/ldap-node.png)

LDAP object are referenced  by its **Distinguished Name** (*DN*). A DN is a sequence of **Relative Distinguished Names** (*RDN*) connected by commas.

An RDN is an attribute with an associated value in the form attribute=value; normally expressed in a UTF-8 string format.

![](img/ldap-tree.png)

**Commonly Used Attributes**

<table>
<tbody><tr><th>String</th><th>Attribute type</th></tr>
<tr><td><strong>DC</strong></td><td>domainComponent</td></tr>
<tr><td><strong>CN</strong></td><td>commonName</td></tr>
<tr><td><strong>OU</strong></td><td>organizationalUnitName</td></tr>
<tr><td><strong>O</strong></td><td>organizationName</td></tr>
<tr><td><strong>STREET</strong></td><td>streetAddress</td></tr>
<tr><td><strong>L</strong></td><td>localityName</td></tr>
<tr><td><strong>ST</strong></td><td>stateOrProvinceName</td></tr>
<tr><td><strong>C</strong></td><td>countryName</td></tr>
<tr><td><strong>UID</strong></td><td>userid</td></tr>
</tbody></table>


## 6.1. Mount your LDAP
### 6.1.1. Your LDAP in the client

For search in the LDAP client need to install **ldap-utils** command. Later We can configure your typical mail client (Thunderbild, for example) to search in the LDAP when you need a compose a mail and need to know the destination account.

### 6.1.2. Your LDAP in the server

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

## 6.2. Check connectivity

![](img/ldap-search.png)

## 6.3. How LDAP works

![](img/ldap-iteration.png)

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

# 7. Mail

Mail is the basic, oldest and most popular service of the internet.

![](img/mail-resume.png)

When you want to send a mail, you going to deposit the mail in the receive mailbox of the receiver, but have a little problem: don't know the adress of the destination mailbox.

For know it, you need to use DNS query of the server name of the mailbox adress, and he say you the direction where you cand send the mail. And also the process is similar when you want to check your mail account. You can see this more later when We analyze the traffic with wireshark.

For support mail, you need support DNS before. This is because mail is based on mailbox concept: All mail accounts need a mailbox for send (**SMTP**) and receive (**POP3** or **IMAP**).

**SMTP**

Define the protocol necessary that transmit the message to the mailbox. 

![image](img/smtp-travel.jpg)

The options about how the message have to be interpreted is described in the **MIME** header.

![](img/smtp-mime.jpg)

`Content-Transfer-Encoding` s to avoid problems relaying the message for differents MTA. Can be:

* base64
* quoted-printable
* 7bit
* 8bit
* binary

The `Content-Type` can be:

* text
* image
* audio
* video
* applitacion
* message
* multipart

Is necesary define `Content-Type` for multipart messages that contains different type (for example text and attachment)

![](img/smtp-multipart.png)

**POP3**

![](img/pop-state.png)

**IMAP**

IMAP keep more stuff in the server, for example, structure of folders and messages that you want to recovery for read it.

The protocol established different states for the connection. Internally, when the connection is established, the server interprets the command that is contained in the messages and do the actions:

![](img/imap-state.png)

## 7.1. Mount your Mail

### 7.1.1 Your Mail in the server

we will set up two typical services for mail:

* **SMTP** is the protocol to can send emails.
* **POP3** is one of the posibles protrocols to receive mails that we are to use. The other common protocol is **IMAP**.


The differences between POP3 and IMAP are littles but importants:


<table border="1" cellspacing="1" cellpadding="7" width="568">
  <tbody><tr>
    <td width="50%" valign="top" bgcolor="#FFFFFF" background="bg.gif">
      <p align="center"><b>POP3</b></p></td>
    <td width="50%" valign="TOP" bgcolor="#ffffff" background="bg.gif">
      <p align="center"><b>IMAP</b></p></td>
  </tr>
  <tr>
    <td width="50%" valign="TOP">Since email needs to be downloaded into
      desktop PC before being displayed, you may have the following problems for
      POP3 access:
      <ul>
        <li>You need to download all email again when using another desktop PC
          to check your email.</li>
        <li>May get confused if you need to check email both in the office and
          at home.</li>
      </ul>
      <p>The downloaded email may be deleted from the server depending on the
      setting of your email client.</p></td>
    <td width="50%" valign="TOP">Since email is kept on server, it would gain
      the following benefits for IMAP access:
      <ul>
        <li>No need to download all email when using other desktop PC to check
          your email.</li>
        <li>Easier to identify the unread email.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="TOP">All messages as well as their attachments will
      be downloaded into desktop PC during the 'check new email' process.</td>
    <td width="50%" valign="TOP">A whole message will be downloaded only when it
      is opened for display from its content.</td>
  </tr>
  <tr>
    <td width="50%" valign="TOP">Mailboxes can only be created on desktop PC.
      There is only one mailbox (INBOX) exists on the server.</td>
    <td width="50%" valign="TOP">Multiple mailboxes can be created on the
      desktop PC as well as on the server.</td>
  </tr>
  <tr>
    <td width="50%" valign="TOP">Filters can transfer incoming/outgoing messages
      only to local mailboxes.</td>
    <td width="50%" valign="TOP">Filters can transfer incoming/outgoing messages
      to other mailboxes no matter where the mailboxes locate (on the server or
      the PC).</td>
  </tr>
  <tr>
    <td width="50%" valign="TOP">Outgoing email is stored only locally on the
      desktop PC.</td>
    <td width="50%" valign="TOP">Outgoing email can be filtered to a mailbox on
      server for accessibility from other machine.</td>
  </tr>
  <tr>
    <td width="50%" valign="TOP">Messages are deleted on the desktop PC.
      Comparatively, it is inconvenient to clean up your mailbox on the server.</td>
    <td width="50%" valign="TOP">Messages can be deleted directly on the server
      to make it more convenient to clean up your mailbox on the server.</td>
  </tr>
  <tr>
    <td width="50%" valign="TOP">Messages may be reloaded onto desktop PC
      several times due to the corruption of system files.</td>
    <td width="50%" valign="TOP">The occurrence of reloading messages from the
      server to PC is much less when compared to POP3.</td>
  </tr>
</tbody></table>



### 7.1.2. Configuring POP3

![](img/pop.png)

1. Install the service **dovecot** for use POP3 in your server.
2. Configure defaults options in `/etc/dovecot/conf.d/10-auth.conf` and `/etc/dovecot/conf.d/10-mail.conf`.

### 7.1.3. Configuring SMTP

![](img/smtp.png)

1. Install the service **exim4**
2. Configure standards options in `/etc/exim4/update-exim4.conf.conf` about your DNS:

```
dc_eximconfig_configtype='internet'
dc_other_hostnames='$DNS_NAME'
dc_local_interfaces=''
dc_readhost=''
dc_relay_domains='$RELAY_DOMAINS'
dc_minimaldns='false'
dc_relay_nets='$LOCAL_NETWORK'
dc_smarthost=''
CFILEMODE='644'
dc_use_split_config='false'
dc_hide_mailname=''
dc_mailname_in_oh='true'
dc_localdelivery='maildir_home'
```

## 7.2. Check connectivity

For the test first we ping the DNS service and later do a telnet in the port of the service.

### 7.2.1. SMTP

![](img/telnet-smtp.png)

### 7.2.2. POP3

![](img/telnet-pop.png)


## 7.3. How Mail Works

### 7.3.1. SMTP

![](img/smtp-header.jpg)

Resume

![](img/smtp-resume.png)

1) Server presentation

![](img/smtp-1.png)

2) Client HELO and sending his IP

![](img/smtp-2.png)

3) Server reply

![](img/smtp-3.png)

4) Client FROM mail account

![](img/smtp-4.png)

5) Server reply

![](img/smtp-5.png)

6) Client send RCTP mail account

![](img/smtp-6.png)

7) Server reply
![](img/smtp-7.png)

8) Client prepare to send DATA

![](img/smtp-8.png)

9) Server reply and say that write a "." to finish the message

![](img/smtp-9.png)

10) Client send the text of the message

![](img/smtp-10.png)
![](img/smtp-11.png)

11) Server reply when the client finish to send the message

![](img/smtp-12.png)

12) Client termiante the connection

![](img/smtp-13.png)

13) Server reply

![](img/smtp-14.png)

### 7.3.2. POP3

The most commonly used commands in a POP3 connection are as follows:

> **USER <username>**
> **PASS <password>**
> Command to make login with a username and password. The server response if the login is correct or not.
>
> **STAT**
> STAT simply responds with a single line consisting of two numbers: the number of messages in the box and the total size of those messages in bytes. It's useful for human beings, but less so for automatic clients, which are likely to jump straight to the LIST command.
>
> **LIST**
> LIST lists the contents of the mailbox, naturally enough. It does so by using the standard POP3 multi-line response format. Here's an example:
>   LIST
>   +OK Mailbox contents follow
>   1 7774
>   2 513
>   3 10493
>   .
> The terminating line is a period on a line by itself, which is pretty standard for mail protocols in general. Each line consists of the mail message number (if you delete one, it won't appear in the list, so don't fall into the trap that the numbers are sequential and can thus be ignored!) followed by the size of the message in bytes.
> LIST plus a message number will simply act like STAT for that message.
>
> **RETR msg**
> RETR retrieves a message. Use the message number from LIST. Note that you'll receive the true text of the message, headers followed by a blank line followed by the body, followed by a period on a line by itself. If the body actually contains a period on a line by itself, the mail server will already have doubled that period. So your client needs to undouble it.
>
> **DELE msg**
> DELE deletes a message. It won't actually be deleted until you QUIT the session, and you can undelete everything you've deleted (in case of a mistake) by using RSET.
>
> **RSET**
> You can reset the session to its initial state using the RSET command. This will undelete all messages deleted using DELE.
>
> **TOP msg n**
> TOP is actually an optional command, but most servers support it now. It returns the headers of message msg plus n lines of the body. If n is zero, of course, you just get the headers, which is nice for doing filtering without having to get the entire message.
>
> **QUIT**
> QUIT terminates the session and deletes any messages marked with DELE.


Resume

![](img/pop-resume.png)

1) Server presentation2.

![](img/pop-1.png)

2) Client identify with USER command

![](img/pop-2.png)

3) Server reply

![](img/pop-3.png)

4) Client type password with PASS command

![](img/pop-4.png)

5) Server reply and say that loggin is correct

![](img/pop-5.png)

6) Client use STAT command

![](img/pop-6.png)

7) Server Reply

![](img/pop-7.png)

8) Client use LIST command

![](img/pop-8.png)

9) Server reply with list of messages

![](img/pop-9.png)

10) Client say that want to see the message No.5

![](img/pop-10.png)

11) Server reply with the message content
![](img/pop-11.png)

12) Client use DELE command

![](img/pop-12.png)

13) Server reply

![](img/pop-13.png)

14) Client use QUIT command for desconnection

![](img/pop-14.png)

15) Server reply

![](img/pop-15.png)

# 8. SSH

SSH (*Secure Shell*)  is a cryptographic network protocol for secure data communication, remote command-line login, remote command execution, and other secure network services between two networked computers.

It was designed as a replacement for Telnet and other insecure remote shell protocols such as the Berkeley rsh and rexec protocols, which send information, notably passwords, in plaintext, rendering them susceptible to interception and disclosure using packet analysis. The encryption used by SSH is intended to provide confidentiality and integrity of data over an unsecured network, such as the Internet.

## 8.1. Mount your SSH

### 8.1.1. Your SSH in the client

The client needs **openssh-client** that is usually installed on UNIX systems default

Also need to generate a **SSH public key** to identify the computer. SSH keys are a way to identify trusted computers, without involving passwords.

**Check your SSH keys**

```
cd ~/.ssh
ls -al
# Lists the files in your .ssh directory
```

**Generate a new SSH key**

```
ssh-keygen -t rsa -C "your_email@example.com"
# Creates a new ssh key, using the provided email as a label
# Generating public/private rsa key pair.
# Enter file in which to save the key (/Users/you/.ssh/id_rsa): [Press enter]
Enter passphrase (empty for no passphrase): [Type a passphrase]
# Enter same passphrase again: [Type passphrase again]
Your identification has been saved in /Users/you/.ssh/id_rsa.
# Your public key has been saved in /Users/you/.ssh/id_rsa.pub.
# The key fingerprint is:
# 01:0f:f4:3b:ca:85:d6:17:a1:7d:f0:68:9d:f0:a2:db your_email@example.com
```

### 8.1.2. Your SSH in the server

Only need to install **openssh-server**.

## 8.2. Check connectivity

![](img/ssh-connect.png)

## 8.3. How SSH works

Resume of messages:

![](img/ssh-resume.png)

1) Client first message

![](img/ssh-1.png)

2) Server first message

![](img/ssh-2.png)

3) Client send `CLIENT_KEY_EXCHANGE`

![](img/ssh-3.png)

4) Server send `CLIENT_KEY_EXCHANGE`

![](img/ssh-4.png)

5) Exchange sucess!

![](img/ssh-5.png)

6)

![](img/ssh-6.png)

7)

![](img/ssh-7.png)

# 9. DHCP

The Dynamic Host Configuration Protocol (*DHCP*) is a standardized networking protocol used on Internet Protocol (IP) networks for dynamically distributing network configuration parameters, such as IP addresses for interfaces and services. With DHCP, computers request IP addresses and networking parameters automatically from a DHCP server, reducing the need for a network administrator or a user to configure these settings manually.

![](img/dhcp-resume.jpg)

Normally is necessary that DHCP is in the same network, but is possible to set this in external network using **DHCP relay** like proxy:

![](img/dhcp-relay.png)

The different message for DHCP protocol are:

<table>
<tbody><tr><th>
<p>
Message Type</p>
</th><th>
<p>
Description</p>
</th></tr>
<tr><td>
<p>
DHCPDiscover</p>
</td><td>
<p>
The first time a DHCP client computer attempts to log on to the network, it requests IP address information from a DHCP server by broadcasting a DHCPDiscover packet. The source IP address in the packet is 0.0.0.0 because the client does not yet have an IP address. The message is either 342 or 576 bytes long—older versions of Windows use a longer message frame.</p>
</td></tr>
<tr><td>
<p>
DHCPOffer</p>
</td><td>
<p>
Each DHCP server that receives the client DHCPDiscover packet responds with a DHCPOffer packet containing an unleased IP address and additional TCP/IP configuration information, such as the subnet mask and default gateway. More than one DHCP server can respond with a DHCPOffer packet. The client will accept the first DHCPOffer packet it receives. The message is 342 bytes long.</p>
</td></tr>
<tr><td>
<p>
DHCPRequest</p>
</td><td>
<p>
When a DHCP client receives a DHCPOffer packet, it responds by broadcasting a DHCPRequest packet that contains the offered IP address, and shows acceptance of the offered IP address. The message is either 342 or 576 bytes long, depending on the length of the corresponding DHCPDiscover message.</p>
</td></tr>
<tr><td>
<p>
DHCPAcknowledge (DHCPAck)</p>
</td><td>
<p>
The selected DHCP server acknowledges the client DHCPRequest for the IP address by sending a DHCPAck packet. At this time the server also forwards any optional configuration parameters. Upon receipt of the DHCPAck, the client can participate on the TCP/IP network and complete its system startup. The message is 342 bytes long.</p>
</td></tr>
<tr><td>
<p>
DHCPNak</p>
</td><td>
<p>
If the IP address cannot be used by the client because it is no longer valid or is now used by another computer, the DHCP server responds with a DHCPNak packet, and the client must begin the lease process again. Whenever a DHCP server receives a request for an IP address that is invalid according to the scopes that it is configured with, it sends a DHCPNak message to the client.</p>
</td></tr>
<tr><td>
<p>
DHCPDecline</p>
</td><td>
<p>
If the DHCP client determines the offered configuration parameters are invalid, it sends a DHCPDecline packet to the server, and the client must begin the lease process again.</p>
</td></tr>
<tr><td>
<p>
DHCPRelease</p>
</td><td>
<p>
A DHCP client sends a DHCPRelease packet to the server to release the IP address and cancel any remaining lease.</p>
</td></tr>
<tr><td>
<p>
DHCPInform</p>
</td><td>
<p>
DHCPInform is a new DHCP message type, defined in RFC&nbsp;2131, used by computers on the network to request and obtain information from a DHCP server for use in their local configuration. When this message type is used, the sender is already externally configured for its IP address on the network, which may or may not have been obtained using DHCP. This message type is not currently supported by the DHCP service provided in earlier versions of Windows&nbsp;NT Server and may not be recognized by third-party implementations of DHCP software. </p>
</td></tr>
</tbody></table>

Simply process in one image:

![image](img/dhcp-works.png)

# 10. FTP
