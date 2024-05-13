# Bash Notes
https://linuxhandbook.com

### Check MAN pages - man "command"
```
man
```

### ls (list)
```
( Hidden files denoted by '.' > .cache )
ls
ls -lisa
ls -latr
ls ~/*.log > returns things in current/home dir ending with .log
```
### create a file
```
touch -t yyyymmddm.ss
```
### mkdir - directory
```
mkdir
mkdir - p  > nest directory
```
### umask - shows default permissions
```
umask
```
### rm - remove file
```
rm -rf  > recursively,force
```
### rmdir - remove directory
```
rmdir -p > removes parent directory
```
# FIND THINGS
### locate 
```
locate find | grep find
locate root | grep root 
```
### whereis 
```
whereis man
whereis root
```
### find 
```
find -name           (case sens)
find -i              (case insens)
find -ilname         (symbolic links)
find -inum           (inode numbers)
find -size +10M -20M (find between 10-20MB)
find -gid 2000       (Group ID 2000)
find -uid 2999       (User ID 2999)
find -maxdepth       (Specify how directories deep to go)
find / -type d       (directories starting from / )
find / -type f       (files starting from / )
find / -type s -exec echo {} 2>/dev/null \; | grep domain*    (s = socket - 2> error code to /dev/null - \; (<-- escaping ; ))
find /var/log -iname *.log -exec ls -al {} 2>/dev/null \;     (exec > execute ls -al after find command - {} > is placeholder for results from previous ls command)

find -cmin -30       (find file changed in last 30mins (3 hours = -180))
Time  = Days
A time = access
C time = changed
M time = modified

