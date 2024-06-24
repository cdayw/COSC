# Network Reconnaissance
https://osintframework.com/
https://www.shodan.io/
https://web-check.xyz/
https://dorksearch.com/
duckduckgo ip lookup****
## Commands
```
hostname
uname -a
ip a
ss -ntlp
** Port 6010 is for terminator
```
## Net Recon Methodolody
```
Host Discovery
  Ruby Ping Sweep (if ping available)
  NMAP scan if no ping

PORT Discovery
  nmap
  nc scan script

Port Validation
  Banner grabbing using nc

Follow-on actions based on ports found
Use BPF to find telnet passwords if available
  if 21 or 80 wget -r IPADDR or wget -r ftp://IPADDR (or) firefox
  if 21 FTP[IP ADDR] connects to ftp service
      passive
      ls
      get [file-name]
  if 22 or 23 CONNECT and PASSIVE RECON
```
## Scan Methodology
```
nmap -Pn IPADDR -T4 -p 21-23,80
  quick scan ports 21-23,80
  specific ports based on hints/clues found
  Well Known port range 0-1023
  Chunks of 2000 or first 10000 ports
  HAIL MARY scan all 65535 ports
```
## Passive Recon Methodology
```
Get computer hostname:
  hostname

Permissions:
  sudo -l

Interfaces and subnets:
  ip a

Neighbors:
  ip neigh

Files of interest:
  find / -iname flag* 2>/dev/null
  find / -iname hint* 2>/dev/null

OTHER LISTENING PORTS:
  ss -ntlp

Available Tools
  **which tcpdump wireshark nmap telnet get curl ping
```

## Reconnaissance Stages
```
    Passive External

    Active External

    Passive Internal

    Active Internal
```
![image](https://github.com/cdayw/COSC/assets/169062872/e4ba6ee6-a51b-42dc-892b-ad64e2621fab)


# Passive External
## Dig
```
dig zonetransfer.me A
dig zonetransfer.me AAAA
dig zonetransfer.me MX
dig zonetransfer.me TXT
dig zonetransfer.me NS
dig zonetransfer.me SOA

dig axfr {@soa.server} {target-site}
dig axfr @nsztm1.digi.ninja zonetransfer.me
```
## Passive OS Fingerprinter (p0f)
```
Use BPF to further scrape through packet info
p0f: Passive scanning of network traffic and packet captures.

test against pcap - ** sudo p0f -r test.pcap
```

# Active External
## Network Service Discovery
```
    Broadcast Ping/Ping sweep (-sP, -PE)

    SYN scan (-sS)

    Full connect scan (-sT)

    Null scan (-sN)

    FIN scan (-sF)

    XMAS tree scan (-sX)

    UDP scan (-sU)

    Idle scan (-sI) ** Utilizes another box for scan 

    ACK/Window scan (-sA)

    RPC scan (-sR)

    FTP scan (-b)

    Decoy scan (-D)

    OS fingerprinting scan (-O)

    Version scan (-sV)

    Protocol ping (-PO)

    Discovery probes (-PE, -PP, -PM)

    -PE - ICMP Ping

    -Pn - No Ping **USE THIS ** Faster, no need for ping ** 
```

## Netcat - Scanning
```
nc [Options] [Target IP] [Target Port(s)]

    -z : Port scanning mode i.e. zero I/O mode

    -v : Be verbose [use twice -vv to be more verbose]

    -n : do not resolve ip addresses

    -w1 : Set time out value to 1

    -u : To switch to UDP **

******NETCAT DOES *NOT* USE -P FOR PORTS*****
```

## Netcat - Banner Grabbing
```
    Find what is running on a particular port

nc [Target IP] [Target Port]
nc 172.16.82.106 22
nc -u 172.16.82.106 53

    -u : To switch to UDP
```

## Banner grabbing 
```
Curl and Wget **

    Both can be used to interact with the HTTP, HTTPS and FTP protocols.

    Curl - Displays ASCII

curl http://172.16.82.106
curl ftp://172.16.82.106

    Wget - Downloads (-r recursive)

wget -r http://172.16.82.106 :port#

wget -r ftp://172.16.82.106 :port#
```

## Passive Internal

## Native Hosts Tools
```
    Show TCP/IP network configuration
Windows: ipconfig /all
Linux: ip address (ifconfig depreciated)
VyOS: show interface

    Show DNS configuration
Windows: ipconfig /displaydns
Linux: cat /etc/resolv.conf

    Show ARP Cache
Windows: arp -a
Linux: ip neighbor

    Show network connections
Windows: netstat
Linux: ss (netstat depreciated)
Example options useful for both netstat and ss: -antp
a = Displays all active connections and ports.
n = No determination of protocol names. Shows 22 not SSH.
t = Display only TCP connections.
u = Display only UDP connections.
p = Shows which processes are using which sockets.

    Services File
Windows: %SystemRoot%\system32\drivers\etc\services
Linux/Unix: /etc/services

    OS Information
Windows: systeminfo
Linux: uname -a OR cat /etc/os-release


    Show Running Processes
Windows: tasklist
Linux: ps -elf or top

    Command path
which
whereis

    Routing Table
Windows: route print
Linux: ip route (netstat -r deprecated)
VyOS: show ip route ** Descriptions are admin comments annotate on map

    File search
find / -iname hint* 2> /dev/null
find / -iname flag* 2> /dev/null
```

# Active Internal
```
Ping Scanning ** CHANGE first three octects inbetween **x.x.x**
for i in {1..254}; do (ping -c 1 **172.16.82**.$i | grep "bytes from" &) ; done
sudo nmap -sP 172.16.82.96/27
```

# MAP CHECKLIST
```
    Device type (Router/host)

    System Host-names

    Interface names (eth0, eth1, etc)

    IP address and CIDRs for all interfaces

    TCP and UDP ports

    MAC Address

    OS type/version

    Known credentials
```
