# Bash Notes

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
find -name (case sens)
find -i (case insens)
find -ilname (symbolic links)
find -inum (inode numbers)
find -size +10M -20M (find between 10-20MB)
find -gid 2000 (Group ID 2000)
find -uid 2999 (User ID 2999)
find -maxdepth (Specify how directories deep to go)
