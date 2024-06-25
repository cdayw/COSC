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
