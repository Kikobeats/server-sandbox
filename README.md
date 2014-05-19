# Server for Dummies

Example of server with basics service for the web!

**NOTE:** This is only a educational example. Don't use in production.

# How to use

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

![image](https://raw.githubusercontent.com/Kikobeats/server-for-dummies/master/doc/examples/main.png)

# List of services

| Services                     | Package                |
| -----------------------------|:----------------------:|
| DNS (Primary and secundary)  | bind9
| SMTP							           | exim4
| POP							             | dovecot-pop3
| IMAP							           | soon
| LDAP							           | slapd, ldap-utils
| HTTP/HTTPS					         | apache2, php5
| SSH							             | openssh
| FTP							             | soon
| IPSEC							           | soon
	
# Test services

All services have been tested in VM VMWare under Ubuntu Server 12.04:

* VM 1 – Main client
* VM 2 – Primary DNS
* VM 3 – Secondary DNS

For test services connectivity run 'Test services'

![image](https://raw.githubusercontent.com/Kikobeats/server-for-dummies/master/doc/examples/testing.png)


# Examples

Include:

* 3 example of domains
	* www1.st.um – Basic domain
	* www2.st.um – Domain with HTTP authentication ([authorized users here](https://github.com/Kikobeats/server-for-dummies/blob/master/Services/HTTP/groups))
	* www3.st.um – Domain with HTTPS (check you are visiting https in the browser!)
	
* 2 mails accounts examples
	* run `./Services/Mail/account.sh` to create it at first time 
	
* LDAP 
	* Sample data for check read and modify operations ([check here](https://github.com/Kikobeats/server-for-dummies/tree/master/Services/LDAP))	 
	

### Example SSL 

![image](https://raw.githubusercontent.com/Kikobeats/server-for-dummies/master/doc/examples/https.png)

### Example Mails 

![image](https://raw.githubusercontent.com/Kikobeats/server-for-dummies/master/doc/examples/mail.png)

### Example SSH

![image](https://raw.githubusercontent.com/Kikobeats/server-for-dummies/master/doc/examples/ssh.png)



