# Stack INFO
```
--Stack Number
  5

--Username
CODA-503-M

--Password
Gx1LjlSgOgQJJMy

Boxes
Student - Password
--Linux ops
10.50.31.135
 
--Windows
10.50.24.133

--Jump
10.50.27.155

--Password
Gx1LjlSgOgQJJMy

--CTFd
http://10.50.20.30:8000/resources
```

## ssh command
```
#MasterSocket
ssh -MS /tmp/jump student@x.x.x.x
-M = Multiplexing
-S = Socket file
allows to use the same tcp connection for multiple boxes

#Dynamic tunnel
ssh -S /tmp/jump dummy -O forward -D 9050

#Chaining port forwards
ssh -S /tmp/jump dummy -O forward -L 1231:192.168.28.100:80 -L 1232:192.168.28.111:80

#Chaining multiple port forwards and going through two socket files to tunnel to another box
ssh -S /tmp/jump dummy -O forward -L 1231:192.168.28.100:80 -L 1232:192.168.28.111:80 -L 4444:192.168.28.111:22
ssh -MS /tmp/t1 student@127.0.0.1 -p 4444

#Cancel out a previously established/incorrect tunnel
ssh -S /tmp/jump dummy -O cancel -L 1231:192.168.28.100:80

#Using previously created socket file to port forward to new pivot        
ssh -S /tmp/t1 dummy -O forward -L 5555:192.168.50.100:22
ssh -MS /tmp/t2 user@127.0.0.1 -p 5555
              ^ creates new socket file BUT still using the singular established TCP connection
```
nmap scripts
```
ls -l usr/share/nmap/scipts
ls -l usr/share/nmap/scipts | grep http

nmap --script=http.enum.nse x.x.x.x
nmap --script=http-enum x.x.x.x
```
## Ping Scan
```
for i in {1..254}; do (ping -c 1 192.168.0.$i | grep "bytes from" &) ; done 2>/dev/null
```

## XML Scraper + script
```
pip install lxml requests
```
```
#!/usr/bin/python
import lxml.html
import requests

page = requests.get('http://quotes.toscrape.com')
tree = lxml.html.fromstring(page.content)

authors = tree.xpath('//small[@class="author"]/text()')

print ('Authors: ',authors)
```
## OPNOTES
```
 14 LinOPS> ssh -S /tmp/jump dummy -O forward -D 9050
 15 LinOPS> proxychains nmap -Pn -T4 192.168.28.97,98,99,100,105,111,120
 16 OUTPUT:
 17 All 1000 scanned ports on 192.168.28.97 are closed
 18 
 19 Nmap scan report for 192.168.28.98
 20 Host is up (0.00051s latency).
 21 Not shown: 999 closed ports
 22 PORT   STATE SERVICE
 23 53/tcp open  domain
 24 
 25 Nmap scan report for 192.168.28.99
 26 Host is up (0.00058s latency).
 27 Not shown: 999 closed ports
 28 PORT   STATE SERVICE
 29 53/tcp open  domain
 30 
 31 Nmap scan report for 192.168.28.100
 32 Host is up (0.00057s latency).
 33 Not shown: 998 closed ports
 34 PORT     STATE SERVICE
 35 80/tcp   open  http
 36 2222/tcp open  EtherNetIP-1
 37 
 38 Nmap scan report for 192.168.28.105
 39 Host is up (0.00052s latency).
 40 Not shown: 997 closed ports
 41 PORT     STATE SERVICE
 42 21/tcp   open  ftp
 43 23/tcp   open  telnet
 44 2222/tcp open  EtherNetIP-1
 45 
 46 Nmap scan report for 192.168.28.111
 47 Host is up (0.00055s latency).
 48 Not shown: 997 closed ports
 49 PORT     STATE SERVICE
 50 80/tcp   open  http
 51 2222/tcp open  EtherNetIP-1
 52 8080/tcp open  http-proxy
 53 
 54 Nmap scan report for 192.168.28.120
 55 Host is up (0.00053s latency).
 56 Not shown: 999 closed ports
 57 PORT     STATE SERVICE
 58 4242/tcp open  vrml-multi-use
 59 
 60 LinOPS > ssh -S /tmp/jump dummy -O forward -L 4141:192.168.28.100:80 -L 212    1:192.168.28.111:80
 61 LinOPS > firefox localhost:2001
 62 
 63 LinOPS > proxychains ssh student@192.168.28.120 -p 4242
 64 DONOVIA05> ip a
 65 OUTPUT: 192.168.28.120/27
 66 
 67 LinOPS> ssh -S /tmp/jump dummy -O forward -L 6666:192.168.28.120:4242
 68 LinOPS> ssh -MS /tmp/t1 student@127.0.0.1 -p 6666
 69 LinOPS> ssh -S /tmp/t1 fug -O forward -D 9050   --> DYNAMIC
```
