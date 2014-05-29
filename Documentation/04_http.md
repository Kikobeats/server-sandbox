# 4. HTTP

HTTP (short for *HyperText Transfer Protocol*) is the underlying protocol used by the World Wide Web. HTTP defines how messages are formatted and transmitted, and what actions Web servers and browsers should take in response to various commands. For example, when you enter a URL in your browser, this actually sends an HTTP command to the Web server directing it to fetch and transmit the requested Web page.


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

## 4.1 Information

| Description  | Service
| -------------	|:-------------
| Aplication	|	HTTP
| Transport		|	TCP
| Network		|   IPv4/IPv6
| Port   		|	80


## 4.2 Mount your HTTP

### 4.2.1 Your HTTP in the client

If you have a Browser and/or terminal, you don't need additional things.


### 4.2.1 Your HTTP in the server

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


## 4.3 Check connectivity

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

## 4.4 How HTTP works

![](img/http-works.png)

![](img/http-resume.png)

1) HTTP Request (GET Command)

![](img/http-1.png)

2) HTTP Response (200 OK code status)

![](img/http-2.png)

