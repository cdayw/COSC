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
mkdir sushi {11,22,33,44,55}   (Creates multiple directories name sushi11 , sushi22 , sushi33 etc.,)
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
find . -maxdepth 3 -type d   ( . > hidden files - 3 > directories deep)
find / -type d       (directories starting from / )
find / -type f       (files starting from / )
find / -type s -exec echo {} 2>/dev/null \; | grep domain*    (s = socket - 2> error code to /dev/null - \; (<-- escaping ; ))
find /var/log -iname *.log -exec ls -al {} 2>/dev/null \;     (exec > execute ls -al after find command - {} > is placeholder for results from previous ls command)
find -executable	   (searches for executable files ONLY)
find -cmin -30       (find file changed in last 30mins (3 hours = -180))
find /var/log/*.txt  (find any .txt in var log)
find /var/log*.txt | grep -v "~" (find any .txt in var log, omitting anything including a ~ )

Time  = Days
A time = access
C time = changed
M time = modified
```
### grep
```
egrep  OR grep -E      (regex)
grep -v root           (inverted search - find everything except for root)
cat /etc/passwd | grep /bin/bash (read file and grep all users with interactive shell)
grep -i                (case insens)
```
### ps  - processes
```
ps -elf
ps -u student (what a user has ran)
ps aux 
```
### Copy all files in the $HOME/1123 directory, that end in ".txt", and omit files containing a tilde "~" character, to directory $HOME/CUT.
```
find -path "$HOME/1123/*.txt" ! -path "$HOME/1123/*~.txt" -exec cp {} $HOME/CUT \;
OR
find $HOME/1123 -iname "*[^~].txt" -exec cp {} $HOME/CUT \;
or
find $HOME/1123 -name "*.txt" ! -name "*~*" -exec cp {} $HOMECUT/. \;
```
## Using ONLY the find command, find all empty files/directories in directory /var and print out ONLY the filename and the inode number, separated by newlines.
```
find /var -empty -printf "%i %f\n"
```
### Using ONLY the find command, find all files on the system with inode 4026532575 and print only the filename to the screen, not the absolute path to the file, separating each filename with a newline. Ensure unneeded output is not visible.
```
find / -inum 4026532575 -printf "%f\n" 2>/dev/null \;
```
### CUT - Used to obtain sections of a file
```
cut -d:-f1 filename      (-d: > delimiter by : , cuts on the colon )
cut -d -f1 -s filename   (-s > 
cut -d: -f2-4 filename   (-f2-4 > shows fields 2 through 4)
``` 
### Using only the ls -l and cut Commands, write a BASH script that shows all filenames with extensions ie: 1.txt, etc., but no directories, in $HOME/CUT.
Write those to a text file called names in $HOME/CUT directory.
Omit the names filename from your output.
```
ls -l $HOME/CUT | cut -d. -f1- -s | cut -d: -f2- -s | cut -d" " -f2 > $HOME/CUT/names
```
### AWK > similar to cut more functionality 
```
awk -F: '{print $1}'         (-F: > is Field delimiter splir on colon : ,  print $1 > print field 1)
awk -F: '{print $0}'         ($0 prints everything involving : delimiter)
awk -F: '{print $1,$3}'      (Prints fields 1 and 3)
awk -F: 'BEGIN {OFS='#'} {print $1,$3}' /etc/passwd             (OFS = Output field seperator prints # within empty space)
awk -F: '($3 == 0) '{print $1}' /etc/passwd                     (Prints field 1 if field 3 = 0 OUTPUTS "root")
awk -F: '{print $NF}' /etc/passwd                               ($NF prints last field)
awk -F: '($3 >= 150){print $1,$6,$3}'                           (if $3 greater than or equal to 150 print fields 1,6,3)
```

### sort > sorts based on ascii table 
```
cat /etc/password | sort   
cat /etc/password | awk -F: '{print$3}' | sort -n   (sorts numerically)
cat /etc/password | awk -F: '{print$3}' | sort -nr  (numerically reversed)
cat /etc/password | awk -F: '{print$3}' | sort -t   (specify field seperator)
cat /etc/password | awk -F: '{print$3}' | sort -u   (uniquely)
ps aux | sort -k 1                                  (-k  = column)    (sort processes by kolumn 1)
ps aux | sort -k 2 -n                               (sort process in kolumn 2 numerically)

```
