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
64 bytes from 10.3.0.27: T3
64 bytes from 10.3.0.221: 
64 bytes from 10.3.0.254: 
64 bytes from 10.3.0.200:

proxychains nmap -Pn -T4 10.30.0.1,10, -p 21-23,80
ssh -D 9050 net1_student5@10.50.20.51 -NT
proxychains wget -r ftp://10.3.0.1
```

## Create a Remote Port Forward from T4 to T3 binding the source as one of Your authorized ports
## Create a Local Port Forward from Internet_Host to T3 targeting the port you just established.
## Identify the flag on Mohammed Web Server
```
internet_host$ telnet {T4_float_ip}     
Telnet to T4 10.2.0.1

Create a Remote Port Forward from T4 to T3 binding the source
pineland$ ssh netX_studentX@{T3_inside_ip} -R NssXX:localhost:22 -NT
ssh net1_student5@10.3.0.10 -R 10510:localhost:22

Create a Local Port Forward from Internet_Host to T3 targeting the port you just established.
internet_host$ ssh netX_studentX@{T3_float_ip} -L NssXX:localhost:NssXX -NT
ssh net1_student5@localhost -p 10511 -L 10505:10.2.0.2:80 -NT

curl http://localhost:10505
wget -r http://localhost:10505
```

## T3 Build a Dynamic tunnel to T3 and conduct active recon to find the Cortina host.
```
internet_host$ ssh netX_studentX@{T3_float_ip} -D 9050 -NT
ssh net1_student5@10.50.20.51 -D 9050 -NT

proxychains ./scan.sh 
Cortina = 10.3.0.1
proxychains wget -r http://{cortina_ip}
```
proxychains ./scan.sh
10.4.0.1
Setup New tunnel to next pivot point
internet_host$ ssh netX_studentX@{T3_float_ip} -L NssXX:{next_pivot_ip}:22 -NT
ssh net1_student5@10.50.20.51 -L 10501:10.4.0.1:22 -NT

Setup up Dynamic port forwarding with 10501
internet_host$ ssh netX_studentX@localhost -p NssXX -D 9050 -NT
ssh net1_student5@127.0.0.1 -D 9050  -p 10501 -NT

## Identify the flag on Mojave's HTTP Server
```
Set up tunnel to 10.4.0.0
ssh net1_student5@10.50.20.51 -L 10501:10.4.0.1:22 -NT

Set up Dynamic Port Forwarding
ssh net1_student5@127.0.0.1 -D 9050 -p 10501 -NT

proxychains wget -r http://10.5.0.1
