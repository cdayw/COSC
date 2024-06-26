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
