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
MasterSocket
ssh -MS student@x.x.x.x
-M = Multiplexing
-S = Socket file
allows to use the same tcp connection for multiple boxes

ssh -S /tmp/jump dummy -O forward -D 9050
```
## Ping Scan
```
for i in {1..254}; do (ping -c 1 192.168.0.$i | grep "bytes from" &) ; done 2>/dev/null
```
