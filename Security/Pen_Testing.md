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
ssh -MS student@x.x.x.x
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

nmap --script=http.enum.nse x.x.x.x
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
