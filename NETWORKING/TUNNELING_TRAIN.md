## Create a Local Port Forward from your Internet_Host to T3 targeting: ip: 10.3.0.27 port: Identify the flag on Victoria's HTTP Server
```
ssh net1_student5@10.50.20.21 -L 10501:10.3.0.27:80 -NT
curl 127.0.0.1:10501
```
## Conduct passive recon on the Target T3, it appears to have access to the 10.3.0.0/24 subnet.
## Create a Dynamic Port Forward from Internet_Host to T3 then use proxychains to pull the flag.
```
ENUMERATE
for i in {1..254}; do (ping -c 1 10.3.0.$i | grep "bytes from" &) ; done

64 bytes from 10.3.0.1: 
64 bytes from 10.3.0.10: 
64 bytes from 10.3.0.27: 
64 bytes from 10.3.0.221: 
64 bytes from 10.3.0.254: 
64 bytes from 10.3.0.200:

proxychains nmap -Pn -T4 10.30.0.1,10, -p 21-23,80
ssh -D 9050 net1_student5@10.50.20.51 -NT
proxychains wget -r ftp://10.3.0.1
```

