# Bash Notes
https://linuxhandbook.com

### Check MAN pages - man "command"
```
man
```
### 10
```
AWK
CUT
SED
FIND
TAR -CZF
GREP
MAX DEPTH
TOUCH
RMDIR
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
touch -t YYMMDDhhmm.ss
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
grep 'CPU\|BIOS' | grep -v 'usable\|reserved'   (grep two things)
egrep "CPU|BIOS" | egrep -iv "unusable\reserved" 
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
awk -F: '($3 == 0)' '{print $1}' /etc/passwd                     (Prints field 1 if field 3 = 0 OUTPUTS "root")
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
### greps ONLY the IP addresses in the text file provided in the current directory); sort them uniquely by number of times they appear.
```
grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' StoryHiddenIPs | sort | uniq -c | sort -nr
```
### Using ONLY the awk command, write a BASH one-liner script that extracts ONLY the names of all the system and user accounts that are not UIDs 0-3.
```
awk -F: '($3 > 3 && $NF == "/bin/bash")''{print $1}' $HOME/passwd > $HOME/SED/names.txt
awk -F: '$3 > 3 && $NF == "/bin/bash" {print $1}' $HOME/passwd > $HOME/SED/names.txt
```
### IF statements - if , elif , fi  
```
#!/bin/bash

if [[-f /etc/passwd ]]; them
  echo "file exists"
elif [[ ! -f /etc/passwd ]]; then
  echo "does not exist"
fi
```
### IF math statements
```
#!/bin/bash

if [[ 3129 == $(( 15645/5 )) ]]; then
  echo "math checks out"
elif [[ 3129 != $(( 15645/5)) ]]; then
  echo "math no good"
fi
```
### SED
```
sed -e  (-e expression for patterns)
s is substitution start pattern
g is for global (lowercase)
d (lowercase) deletes
$ means end of line

sed -e 's/chicken/hamburger/g' -e 's/pepperoni/sausage/' pizza.txt
sed 's 's/chicken/hamburger/g' pizza.txt
sed -e '/chicken/d' pizza.txt
sed -e 's/chicken/hamburger/g' pizza.txt
````
### Command Substitution 
```
#!/bin/bash
A=$(tail /etc/passwd)
echo $A

B=$(find /usr/bin -name passwd)
echo $B
echo
md5sum $B
echo
echo $B
```
###  Write a Bash script using "Command Substitution" to replace all passwords, using openssl, from the file $HOME/PASS/shadow.txt with the MD5 encrypted password: Password1234, with salt: bad4u
```
a=$(openssl passwd -1 -salt bad4u Password1234)
awk -F: -v "awk_var=$a" 'BEGIN {OFS=":"} {$2=awk_var} {print $0}' $HOME/PASS/shadow.txt
OR
awk -v hh=$HASH '{OFS":"}{$2=hh;print}' $HOME/PASS/shadow.txt
```
### Using ONLY sed, write all lines from $HOME/passwd into $HOME/PASS/passwd.txt that do not end with either /bin/sh or /bin/false
```
sed -e '/\/bin\/sh$/d' -e '/\/bin\/false$/d' $HOME/passwd > $HOME/PASS/passwd.txt
```
### Simple IF 
```
contents=$(cat simple)
if [[ $contents == "tacos "]]; then
  echo "are good on tuesdays"
elif [[ $contents == "costco is amazing" ]]; then
  echo "will save you money"
elif [[ $contents == "chicken bake" ]]; then
  echo "tasty but will make you fat"
else
  echo "no tax at commissary"
fi
```
### Using find, find all files under the $HOME directory with a .bin extension ONLY.
Once the file(s) and their path(s) have been found, remove the file name from the absolute path output
```
find $HOME -name *.bin -printf "%h\n" 2>/dev/null | sort -u
```
### 
  Write a script which will copy the last entry/line in the passwd-like file specified by the $1 positional parameter
    Modify the copied line to change:
        User name to the value specified by $2 positional parameter
        Used id and group id to the value specified by $3 positional parameter
        Home directory to a directory matching the user name specified by $2 positional parameter under the /home directory
        The default shell to `/bin/bash'
    Append the modified line to the end of the file

```
name=$2
ugid=$3
file=$1
base=$(tail -1 $file)

echo $base | awk -F: -v "var2=$name" -v "var3=$ugid" 'BEGIN {OFS=":"} {$1=var2} {$3=var3} {$4=var3} {$6="/home/"var2} {$NF="/bin/bash"} {print $0}' >> $file
```
### 
Find all executable files under the following four directories:
/bin
/sbin
/usr/bin
/usr/sbin
Sort the filenames with absolute path, and get the md5sum of the 10th file from the top of the list.
```
md5sum $(find /bin /sbin /usr/bin /usr/sbin -executable -type f | sort -u | head | tail -1) | cut -d" " -f1
```
###
Write a script which will find and hash the contents 3 levels deep from each of these directories: /bin /etc /var
    Your script should:
        Exclude named pipes. These can break your script.
        Redirect STDOUT and STDERR to separate files.
        Determine the count of files hashed in the file with hashes.
        Determine the count of unsuccessfully hashed directories.
        Have both counts output to the screen with an appropriate title for each count.
```
mkdir $HOME/HASHES
find /bin /etc/ var -maxdepth 3 ! -type p -exec md5sum {} > $HOME/ASHES/success 2>$HOME/HASHES/fail \;
A=$(wc -l $HOME/HASHES/success) | awk '{print $1}')
B=$(grep -c "Is a Directory" $HOME/HASHES/fail)
if [[ "$A" ]];
  then
    `echo "Successfully Hashed Files: $A";
    echo Unsuccessfully Hashed Directories: $B;
  else
    echo "oops";-maxdepth 3
fi

OR

find $DIRS -maxdepth 3 ! -type p -exec md5sum {} \; >STDOUT.del 2>STDERR.del
GoodCount=$(cat STDOUT.del | wc -l)
BadCount=$(egrep "Is a" STDERR.del | wc -l)
echo "Successfully Hashed Files: $GoodCount"
echo "Unsuccessfully Hashed Directories: $BadCount"
rm *.del
```
###
using any BASH command complete the following:
Sort the /etc/passwd file numerically by the GID field.
For the 10th entry in the sorted passwd file, get an md5 hash of that entry’s home directory.
Output ONLY the MD5 hash of the directory's name to standard output.
```
awk -F: '{print $4 , $0}' /etc/passwd | sort -n | head | tail -1 | awk -F: '{print $6}' | md5sum | cut -d" " -f1
```
###
D,esign a script that detects the existence of directory: $HOME/.ssh
Upon successful detection, copies any and all files from within the directory $HOME/.ssh to directory $HOME/SSH and produce no output. You will need to create $HOME/SSH.
Upon un-successful detection, displays the error message "Run ssh-keygen" to the user.
```
if [[ -d $HOME/.ssh ]]; then
    mkdir $HOME/SSH
    cp $HOME/.ssh/* $HOME/SSH/ 
else
    echo "Run ssh-keygen"
fi
```
### Write a script that determines your default gateway ip address. Assign that address to a variable using command substitution
```
A=$(route | grep 'default.*[[:digit:]]' | awk '{print $2}')
B=$(which ping)
C=" 0% packet loss"
D=$($B -c 6 $A | grep -Eo "$C")
if [[ "$C" == "$D" ]]; then
    echo "successful"
else 
    echo "failure"
fi
```
###
Create the following files in a new directory you create $HOME/ZIP:
    file1 will contain the md5sum of the text 12345
    file2 will contain the md5sum of the text 6789
    file3 will contain the md5sum of the text abcdef
Create a zip file containing the three files above, without being stored inside a directory in the zip file. Name the zip file $HOME/ZIP/file.zip
Utilize tar on $HOME/ZIP/file.zip to archive it into a file called $HOME/ZIP/file.tar.gz which should not include directories.
```
mkdir $HOME/ZIP
echo "12345" | md5sum | cut -d" " -f1 > $HOME/ZIP/file1
echo "6789" | md5sum | cut -d" " -f1 > $HOME/ZIP/file2
echo "abcdef" | md5sum | cut -d" " -f1 > $HOME/ZIP/file3
zip -j $HOME/ZIP/file.zip $HOME/ZIP/file{1,2,3}
tar -czf $HOME/ZIP/file.tar.gz -C $HOME/ZIP file.zip
```
### TAR
```
Switch 	Expansive Options 	Description
-c, 	–create 	create a new archive
-d, 	–diff, –compare 	find differences between archive and file system
-r, 	–append 	append files to the end of an archive
-t, 	–list 	list the contents of an archive
-u, 	–update 	only append files newer than copy in archive
-x, 	–extract, –get 	extract files from an archive
-j, 	–bzip2 	filter the archive through bzip2
-z, 	–gzip, –gunzip, –ungzip 	filter the archive through gzip
```
# PRACTICE
### Replace every instance of 'cat' in "infile" with 'dog'.
Replace every instance of 'Navy' in "infile" with 'Army'.
Replacements are case-sensitive.
Write the output to the file specifed by the variable 'outfile'
```
infile=$1
outfile=$2
sed -e 's/cat/dog/g' -e 's/Navy/Army/g' $1 > $2
```
### Create a script that will print to standard output all user names from the /etc/passwd file
```
awk -F: '{print $1}' /etc/passwd | sort -r
OR
cut -d':' -f1 /etc/passwd
```
### Print to standard output all usernames from the file path specified by the parameter filename sorted ascending numerically by user id
```
awk -F: '{print $3, $0}' $1 | sort -n | awk -F" " '{print $2}' | awk -F: '{print $1}'
OR
sort -n -t: -k3 fakepasswd.txt | cut -d":" -f1
```
### Create a script that will perform the following actions:
Print to standard output the total number of files in the directory specified by dirname.
If the directory does not exist, print 'Invalid Directory'
The count excludes the '.' and '..' pseudo-directories
```
dirname=$1
ls -1 $1 | wc -l
```
### Create a script that will perform the following actions:
Delete all files contained in the directory specified by dirdel
  Also delete the directory specified by dirdel
```
dirdel=$1
rm -rf $1 
```
### Create a file specified by the name newfile.
Set the file modified date to the value specified in filedate and time to '1730'. NOTE: filedate contains only a valid date in YYYYMMDD format, not a time
```
newfile=$1
filedate=$2
D=$2"1730.00"
touch -m -t $D $1
OR
touch -t "$filedate"1730 $newfile
OR
touch $1 -t $21730
```
### 
If contents are 0 to 9, print "single digit" to standard output.
If contents are 10 to 99, print "double digit" to standard output.
If contents are 100 to 999, print "triple digit" to standard output.
Otherwise, print "Error" to standard output
```
  fname=$1
  cont=$(cat $1)
    if [[ $cont -lt 10 ]] ; then
        echo "single digit"
    elif [[ $cont -gt 10 && $cont -lt 99 ]] ; then 
        echo "double digit"
    elif [[ $cont -gt 100 && $cont -lt 999 ]] ; then
        echo "triple digit"
    else 
        echo "Error"
    fi
```
### Copy all lines from the file specified by src variable to the file specified by dst variable which DO NOT contain the text specified by match variable
```
  src=$1
  dst=$2
  match=$3
  grep -v $3 $1 > $2
```
### Terminate the process that has the randomly assigned name specified by procname variable. procname does not contain path information
```
procname=$1
pkill $1
```
### Create a sorted full-path list of all files in the directory dirpath that were modified within the previous day. Directories should not be included in the output. Print the list to the screen, one item per line
```
dirpath=$1
find $1 -type f -mtime -1 | sort
```
### /+
```
find .type -f -exec tar -czf archive.tar.gz {} +
grep -E 'apple|banana' file.txt | grep -Ev 'orange'
grep -E '(^apple|banana$)' file.txt   
```
