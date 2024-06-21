# Network Reconnaissance
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
