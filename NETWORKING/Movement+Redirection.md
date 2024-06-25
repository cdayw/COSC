# Movement and Redirection

## File Transfer and Redirection
## Methods of Trasnfering Data 
```
TFTP

FTP

Active

Passive

FTPS

SFTP

SCP
```

## SCP Syntax - ** Similar to ssh
```
Download a file from a remote directory to a local directory
    user     targetIP    :   *tgtfile     *dir on our box
scp student@172.16.82.106:secretstuff.txt /home/student
```
## Upload a file to a remote directory from a local directory
```
scp secretstuff.txt student@172.16.82.106:/home/student
```
## Copy a file from a remote host to a separate remote host
```
$ scp -3 student@172.16.82.106:/home/student/secretstuff.txt student@172.16.82.112:/home/student
```
## Recursive download of a folder from remote
```
scp -r student@172.16.82.106:folder/ .
```
## Download a file from a remote directory to a local directory
```
$ scp -P 1111 student@172.16.82.106:secretstuff.txt .
```
## ***TWO THINGS TO INTERACT WITH A TUNNEL**
```
Loopback address
Port Attached to that tunnel
```

# SCP Syntax through a tunnel
## Create a local port forward to target device
```
ssh student@172.16.82.106 -L 1111:127.0.0.1:22 -NT
```
## Download a file from a remote directory to a local directory
```
scp -P 1111 student@localhost:secretstuff.txt /home/student
```
## Upload a file to a remote directory from a local directory
```
scp -P 1111 secretstuff.txt student@localhost:/home/student
```
# SCP Syntax through a Dynamic Port forward
```
Create a Dynamic Port Forward to target device
ssh student@172.16.82.106 -D 9050 -NT

Download a file from a remote directory to a local directory
proxychains scp student@localhost:secretstuff.txt .
```
## Netcat file/data transfer
```
NETCAT: Client to Listener file transfer
Listener (receive file):
nc -lvp 9001 > newfile.txt

Client (sends file):
nc 172.16.82.106 9001 < file.txt
```
```
NETCAT: Listener to Client file transfer
Listener (sends file):
nc -lvp 9001 < file.txt

Client (receive file):
nc 172.16.82.106 9001 > newfile.txt
```
## Netcat Relay - LISTENER - LISTENER **
![image](https://github.com/cdayw/COSC/assets/169062872/c9a22c9b-4f63-4a80-91c5-69d931c9c71a)
```
SEND  RELAY  RECEIVE
 IH -> BH1 <-BPH1

STEP1
On Blue_Host-1 Relay:
Making a Named Pipe:
mknod pipe p
 or
 mkfifo pipe
nc -lvp 1111 < mypipe | nc -lvp 3333 > mypipe

STEP2
On Internet_Host (send):
nc 172.16.82.106 1111 < secret.txt
        ^Blue_Host Public IP facing Internet_Host

STEP3
On Blue_Priv_Host-1 (receive):
nc 192.168.1.1 3333 > newsecret.txt
        ^Blue_Host private IP facing BPH1
```

## Netcat Relay - Client to Client **
![image](https://github.com/cdayw/COSC/assets/169062872/b22e22a6-b4bb-4ea8-8dc5-5e6afec1ad79)
```
On Internet_Host (send):
nc -lvp 1111 < secret.txt

On Blue_Priv_Host-1 (receive):
nc -lvp 3333 > newsecret.txt

On Blue_Host-1 Relay:
mknod mypipe p
nc 10.10.0.40 1111 < mypipe | nc 192.168.1.10 3333 > mypipe
```
## Netcat Relay - Client - Listener
![image](https://github.com/cdayw/COSC/assets/169062872/abd77453-d445-4e4a-b4a9-e5896dd9c6f7)

```
    On Internet_Host (send):

$ nc -lvp 1111 < secret.txt

    On Blue_Priv_Host-1 (receive):

$ nc 192.168.1.1 3333 > newsecret.txt

    On Blue_Host-1 Relay:

$ mknod mypipe p
$ nc 10.10.0.40 1111 < mypipe | nc -lvp 3333 > mypipe
```
## Netcat Relay - Listener - Client
![image](https://github.com/cdayw/COSC/assets/169062872/4c0f01b3-e9a9-475a-9855-d6be599cb306)
CLIENT is already set up on BPH1
```
    On Internet_Host (send):

$ nc 172.16.82.106 1111 < secret.txt

    On Blue_Priv_Host-1 (receive):

$ nc -lvp 3333 > newsecret.txt

    On Blue_Host-1 Relay:

$ mknod mypipe p
$ nc -lvp 1111 < mypipe | nc 192.168.1.10 3333 > mypipe
```
