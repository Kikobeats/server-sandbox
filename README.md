![image](https://raw.githubusercontent.com/Kikobeats/server-for-dummies/master/examples/main.png)

Example of server with basics service for the web!

**NOTE:** This is only a educational example. Don't use in production.

# How to use

`cd server-for-dummies && sudo sh init.sh`

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

All services are tested in Ubuntu Server 12.04.

For test services connectivity run 'Test services'

![image](https://raw.githubusercontent.com/Kikobeats/server-for-dummies/master/examples/testing.png)


# Examples

Include:

* 3 example of domains
	* www1.st.um – Basic domain
	* www2.st.um – Domain with HTTP authentication
	* www3.st.um – Domain with HTTPS
	
* 2 mails accounts examples
	

### Example SSL 

![image](https://raw.githubusercontent.com/Kikobeats/server-for-dummies/master/examples/https.png)

### Example Mails 

![image](https://raw.githubusercontent.com/Kikobeats/server-for-dummies/master/examples/mail.png)

### Example SSH

![image](https://raw.githubusercontent.com/Kikobeats/server-for-dummies/master/examples/ssh.png)



