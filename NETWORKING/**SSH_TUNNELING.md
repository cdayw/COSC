# SSH TUNNELING
## Covert Channel Tools
```
ptunnel
Loki
007shell
ICMP Backdoor
B0CK
Hans
OzymanDNS
NSTX
dns2tcp
iodine
heyoka
dnscat2
tunnelshell tools
HTTPTunnel
SirTunnel
go HTTP tunnel
```
![image](https://github.com/cdayw/COSC/assets/169062872/0380949c-ead9-4a12-973d-ee80627fef69)

## Tunneling example
```
Local    Auth. peice            Tunnel Piece
ssh student@172.168.1.1 -L 1111:192.168.1.2:80 -NT
    |__________________||_____||______________|

Remote    Auth. Piece          Tunnel Piece 
ssh student@192.168.1.1 -R 9999:127.0.0.1:22 -NT
    |_________________________| |__________|
```

# Local Port Forwarding
```
ssh -p <optional alt port> <user>@<server ip> -L <local bind port>:<tgt ip>:<tgt port> -NT

or

ssh -L <local bind port>:<tgt ip>:<tgt port> -p <alt port> <user>@<server ip> -NT


```

## Local Port Forward to localhost of server
```
Internet_Host:
ssh student@172.16.1.15 -L 1122:localhost:22
or
ssh -L 1122:localhost:22 student@172.16.1.15

Internet_Host:
ssh student@localhost -p 1122
Blue_DMZ_Host-1~$
```

## Local Port Forward to localhost of server
```
Internet_Host:
ssh student@172.16.1.15 -L 1123:localhost:23
or
ssh -L 1123:localhost:23 student@172.16.1.15

Internet_Host:
telnet localhost 1123
Blue_DMZ_Host-1~$
```

## Local Port Forward to localhost of server
```
Internet_Host:
ssh student@172.16.1.15 -L 1180:localhost:80
or
ssh -L 1180:localhost:80 student@172.16.1.15

Internet_Host:
firefox http://localhost:1180
{Webpage of Blue_DMZ_Host-1}
```

## Local Port Forward to remote target via server
```
Internet_Host:
ssh student@172.16.1.15 -L 2222:172.16.40.10:22
or
ssh -L 2222:172.16.40.10:22 student@172.16.1.15

Internet_Host:
ssh student@localhost -p 2222
Blue_INT_DMZ_Host-1~$
```
## Local Port Forward to remote target via server
```
Internet_Host:
ssh student@172.16.1.15 -L 2223:172.16.40.10:23
or
ssh -L 2223:172.16.40.10:23 student@172.16.1.15

Internet_Host:
telnet localhost 2223
Blue_INT_DMZ_Host-1~$
```
## Local Port Forward to remote target via server
```
Internet_Host:
ssh student@172.16.1.15 -L 2280:172.16.40.10:80
or
ssh -L 2280:172.16.40.10:80 student@172.16.1.15

Internet_Host:
firefox http://localhost:2280
{Webpage of Blue_INT_DMZ_Host-1}
```
## Forward through Tunnel
```
Internet_Host:
ssh student@172.16.1.15 -L 2222:172.16.40.10:22
ssh student@localhost -p 2222 -L 3322:172.16.82.106:22

Internet_Host:
ssh student@localhost -p 3322
Blue_Host-1~$
```
## Forward through Tunnel
```
Internet_Host:
ssh student@172.16.1.15 -L 2222:172.16.40.10:22
ssh student@localhost -p 2222 -L 3323:172.16.82.106:23

Internet_Host:
telnet localhost 3323
Blue_Host-1~$
```
## Forward through Tunnel
```
Internet_Host:
ssh student@172.16.1.15 -L 2222:172.16.40.10:22
ssh student@localhost -p 2222 -L 3380:172.16.82.106:80

Internet_Host:
firefox http://localhost:3380
{Webpage of Blue_Host-1}
```

## Dynamic Port Forwarding
** Port 9050 can only be used once
```
ssh <user>@<server ip> -p <alt port> -D <port> -NT
or
ssh -D <port> -p <alt port> <user>@<server ip> -NT

    Proxychains default port is 9050***

    Creates a dynamic socks4 proxy that interacts alone, or with a previously established remote or local port forward.

    Allows the use of scripts and other userspace programs through the tunnel.
```
## SSH Dynamic Port Forwarding 1-Step
Does not support UDP or ICMP
```
Internet_Host:
ssh student@172.16.1.15 -D 9050
or
ssh -D 9050 student@172.16.1.15
``` 
## SSH Dynamic Port Forwarding 1-Step
```
Internet_Host:
proxychains ./scan.sh
proxychains nmap -Pn 172.16.40.0/27 -p 21-23,80
proxychains ssh student@172.16.40.10
proxychains telnet 172.16.40.10
proxychains wget -r http://172.16.40.10 **
proxychains wget -r ftp://172.16.40.10 **
```

## Remote Port Forwarding 
```
ssh -p <optional alt port> <user>@<server ip> -R <remote bind port>:<tgt ip>:<tgt port> -NT

or

ssh -R <remote bind port>:<tgt ip>:<tgt port> -p <alt port> <user>@<server ip> -NT
```
## Remote Port Forwarding from localhost of client
Access Webserver via alternate port 
```
Blue_DMZ_Host-1:
ssh student@10.10.0.40 -R 4480:localhost:80
or
ssh -R 4480:localhost:80 student@10.10.0.40

Internet_Host:
firefox http://localhost:4480
{Webpage of Blue_DMZ_Host-1}
```
## Remote Port Forwarding to remote target via client
```
Blue_DMZ_Host-1:
ssh student@10.10.0.40 -R 5580:172.16.40.10:80
or
ssh -R 5580:172.16.40.10:80 student@10.10.0.40

Internet_Host:
firefox http://localhost:5580
{Webpage of Blue_INT_DMZ_Host-1}
```

# Combining Local and Remote Port Forwarding
## Bridging Local and Remote Port Forwarding
```
Internet_Host:
ssh student@172.16.1.15 -L 2223:172.16.40.10:23 -NT
or
ssh -L 2223:172.16.40.10:23 student@172.16.1.15 -NT

Internet_Host:
telnet localhost 2223
Blue_INT_DMZ_Host-1~$

Blue_INT_DMZ_Host-1:
ssh student@172.16.1.15 -R 1122:localhost:22
or
ssh -R 1122:localhost:22 student@172.16.1.15

Internet_Host:
ssh student@172.16.1.15 -L 2222:localhost:1122
or
ssh -L 2222:localhost:1122 student@172.16.1.15

Internet_Host:
ssh student@localhost -p 2222 -D 9050
or
ssh -D 9050 student@localhost -p 2222

Internet_Host:
proxychains ./scan.sh
proxychains nmap -Pn -sT 172.16.82.96/27 -p 21-23,80
proxychains ssh student@172.16.82.106
proxychains telnet 172.16.82.106
proxychains wget -r http://172.16.82.106
proxychains wget -r ftp://172.16.82.106
```

## Tunneling Activity
![image](https://github.com/cdayw/COSC/assets/169062872/97086d70-a683-45fa-b28b-4c4e7765f571)
## Tunneling Activity
```
IH> ssh student@10.50.30.99 -D 9050 -NT
IH> Proxychains nmap 192.168.1.32/27 -Pn -T4 -p 21-23,80
Found .39 HOST B

## Change SSH command to setup local port forward
IH> ssh student@10.50.30.99 -L 12345:192.168.1.39:22 -NT (THIS ONE STAYS UP)
^ 12345 is opened on **IH/LocalHost**
IH> ssh student@127.0.0.1 -p 12345
##  ^ This will ssh to .39 via the tunnel setup on port 12345
** ENUMERATE - Find Open ports other info

IH> ssh student@127.0.0.1 -p 12345 -D 9050
## Prepare Proxychains with 9050
## Scan previously discovered net range
IH> proxychains ./scan.sh or nmap 10.0.0.0/26
Found .50 HOST C

IH> ssh student@127.0.0.1 -p 12345 -L 23456:10.0.0.50:22 -NT
This creates a tunnel via 23456 on IH ---^                   
## Test ssh to HOST C 10.0.0.50
IH> ssh student@127.0.0.1 -p 23456
## Prepare proxychains/Dyanamic Port forwarding with 9050
IH> ssh student@127.0.0.1 -p 23456 -D 9050
** ENUMERATE - Find Open ports other info
IH> proxychains ./scan.sh or nmap 172.16.1.0/28
Found Host D 172.16.1.8

## Ensure to close out previously setup Dynamic Port forward on 9050 before setting up another
## If more than one is attempted will get ** BIND ERROR ** 
IH> ssh student@127.0.0.1 -p 23456 -L 1122:172.16.1.8:22 -NT
## Test ssh to HOST D 172.16.1.8
IH> ssh student@127.0.0.1 -p 1122
IH> ssh student@Local^Host -p1122 -D 9050 -NT 

```

Creds:
```
10.50.24.91
Credentials: net{N}_studentX:passwordX
T3 (Atropia) Float IP address is - 10.50.20.51

T4 (Pineland) Float IP address is - 10.50.24.9 (Note - You can only telnet here to act as an insider, this will not be a routed path)
```


![image](https://github.com/cdayw/COSC/assets/169062872/38975df0-5d16-43aa-b8ab-6a75bc8866eb)
## Tunnel Prep 
```
6
Which ssh syntax would properly setup a Local tunnel to PC1 SSH port? (Max 2 Attempts)
A. ssh -L 1111:localhost:22 cctc@10.50.1.150 -NT

7
Which ssh syntax would allow us to establish a Dynamic tunnel using the Local tunnel created in Question 6? (Max 2 Attempts)
D. ssh -D 9050 cctc@localhost -p 1111 -NT

8
Which syntax would allow us to download the webpage of PC1 using the Local tunnel created in Question 7? (Max 2 Attempts)
C. wget -r http://localhost:1111

9
Which syntax would allow us to download the webpage of PC2 using the Dynamic tunnel created in Question 8? (Max 2 Attempts)
C. proxychains curl http://100.1.1.2

10
Which syntax would allow us to download the webpage of PC2 using the Dynamic tunnel created in Question 8? (Max 2 Attempts)
B. proxychains wget -r http://100.1.1.2

11
Which ssh syntax would properly setup a Local tunnel to PC2 SSH port using PC1 as your pivot? (Max 2 Attempts)
A. ssh cctc@10.50.1.150 -L 1111:192.168.2.1:22 -NT 

12
Which ssh syntax would properly setup a 2nd Local tunnel to PC2 SSH port using the tunnel made in Question 6 as your first tunnel? (Max 2 Attempts)
A. ssh -L 2222:100.1.1.2:22 cctc@localhost -p 1111 -NT

13
Which ssh syntax would properly setup a 2nd Local tunnel to PC2 HTTP port using the tunnel made in Question 6 as your first tunnel? (Max 2 Attempts)
B. ssh cctc@localhost -p 1111 -L 2222:100.1.1.2:80 -NT

14
Which ssh syntax would allow us to establish a Dynamic tunnel using the Local tunnel created in Question 12? (Max 2 Attempts)
A. ssh -D 9050 cctc@localhost -p 2222 -NT

15
From the OPS workstation, the Admin is trying to create a Dynamic tunnel to PC2. They created the following tunnels but found that the Dynamic tunnel would not connect. Where did the Admin make the error? (Max 2 Attempts)
1.) ssh cctc@10.50.1.150 -L 1234:100.1.1.2:22 -NT
2.) ssh -D 9050 cctc@100.1.1.2 -p 1234 -NT 
C. authenticated to wrong IP in line 2

16
From the OPS workstation, the Admin is trying to telnet through the tunnels to PC3. The Admin created the following tunnels but found that the telnet connection would not connect. Where did the Admin make the error? (Max 2 Attempts)
1.) ssh cctc@10.50.1.150 -L 1234:192.168.2.1:22 -NT
2.) ssh -L 4321:192.168.2.2:23 cctc@localhost -p 1234 -NT
3.) telnet localhost 4321
A. targeted wrong IP in line 1

17
Which ssh syntax would properly setup a 3rd Local tunnel to PC3 TELNET port using the tunnels made in Question 6 and Question 12? (Max 2 Attempts)
D. ssh -p 2222 cctc@localhost -L 3333:192.168.2.2:23 -NT

18
Which syntax would allow us to telnet to PC3 using the tunnel made in Question 17? (Max 2 Attempts)
B. telnet localhost 3333

19
Which syntax would properly setup a Remote tunnel from PC3 back to PC2 using PC3 SSH port as the target? (Max 2 Attempts)
C. ssh -R 4444:localhost:22 cctc@192.168.2.1 -NT

20
Which syntax would properly setup a Local tunnel to map to the tunnel made in Question 19 using the tunnel made in Question 6 and Question 12? (Max 2 Attempts)
A. ssh cctc@localhost -p 2222 -L 5555:localhost:4444 -NT 
```

## Tunnel Practice 2
![image](https://github.com/cdayw/COSC/assets/169062872/75bd8b52-4694-4d8c-8170-8f68e37e7817)
```
Build Dynamic tunnels

IH> Telnet 10.50.29.19
A> ssh student@10.50.23.21 -R 11602:LocalHost:22 -NT
IH> ssh student@10.50.29.19 -D 9050 -p11602 -NT

IH> ssh student@127.0.0.1 - p 11602 -L 11603:10.1.2.18:2222 -NT 
IH> ssh student@127.0.0.1 -D 9050 -p 11603 -NT 

IH> student@localhost -p 11603 -L 11604:172.16.10.121:2323 -NT 
IH> student@localhost -D 9050 -p 11604 -NT

IH> student@localhost -p11604 11605:192.168.10.69:22 -NT
IH>student@localhost -D 9050 -p 11605 -NT
```
