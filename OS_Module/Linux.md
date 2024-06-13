# Linux Essentials 
https://hadess.io/the-art-of-linux-persistence/
escalate to root - sudo find /etc/passwd -exec /bin/sh \;
## Linux Filesystem
```
The root directory of the file system /
Everything starts from this directory. Think of it as the doorway to the Linux Filesystem


Essential user commands in /bin
Contains commands like ls and echo which every user can use.


User Directories in /home
Contains directories for every non-root user on the system (with a home directory and login shell)


Host specific system configurations in /etc
Stands for everything configurable
Contains network configurations, system services(daemons), firewall configurations, etc.


Variable data files in /var
Contains all of the system logs by default
```
### **IMPORTANT
```
YOU CAN READ FILES WITHIN A DIRECTORY EVEN IF YOU DON'T HAVE PERMISSIONS TO ACESS THE DIRECTORTY
It’s also important to understand that file permissions do not overrule directory permissions. If a user does not have read rights to a directory, it also cannot read any of its files even if the file’s permissions allow it
```
## Special Permissions: SUID and SGID
```
When an executable is ran in Linux, it runs with the permissions of the user who started it. However, SUID and SGID change that to force the executable to run as the owning user or group. These permissions are represented as s in the User or Group field of ls- l
```
## What argument/switch option, when used with man, will search the short descriptions and man-page-names for a keyword that you provide?
```
man -k
```
## Hash with largest hash possible
```
echo -n "OneWayBestWay" | sha512sum
```
## Search the user home directories to find the file with the second-most lines in it. The flag is the number of lines in the file
```
find /home/* -type f -exec wc -l {} + 2>/dev/null | sort -rn
```
## Pull the comment from etc/passwd file
```
cat /etc/passwd | cut -d: -f5
```
## Get Users in lodge group
```
sudo cat /etc/group | grep -i lodge | cut -d: -f4 |
```
## Find user with unique login shell
```
sudo cat /etc/passwd | cut -d: -f1,7 | grep -v nologin
```
## Verify user group permissions/existence of groups
```
groups
groups <username>
```
## Locate the file within /media/Bibliotheca that is modifiable by the only user that is part of the chapter group, but not part of the lodge group.
```
cat /etc/group | grep -i lodge
cat /etc/group | grep -i chapter
find  /media/Bibliotheca/* -type f -user <username> -perm /u=w
```
## Identify the file within /media/Bibliotheca where the owning group has more rights than the owning user.
```
find  /media/Bibliotheca/* -type f -perm /g=rwx -exec ls -l {} \;
```
## Execute the file owned by the guardsmen group in /media/Bibliotheca, as the owning user.
```
find  /media/Bibliotheca/* -type f -group guardsmen -exec ls -l {} \;
sudo -u gaunt ./filename
```
## Locate the file in /media/Bibliotheca that Quixos has sole modification rights on.
```
find  /media/Bibliotheca/* -type f -user quixos -perm /u=w -exec ls -l {} \;
```
## Locate the file in /media/Bibliotheca that Quixos has sole modification rights on.
```
find  /media/Bibliotheca -name '.*' -type f -exec ls -l {} \;
```
## Using the commands ls and grep, identify the number of directories in /etc/ that end in .d
```
ls -l /etc | egrep "\.d$"
```
## Use regular expressions to match patterns similar to valid and invalid IP addresses.
```
grep -E -o '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' numbers | wc -l
```
## Use Regex to find valid ips
```
grep -E '^(([01]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.){3}([01]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$' numbers | wc -l
```
# DAY 5 LINUX BOOT

## BOOT PROCESS
```
BIOS              UEFI
 |		   |
MBR               GPT
 |		   |
GRUB              GRUB.efi
   \ LINUX KERNEL /
	init
      /      \	
Sysv INIT      Systemd init
    |		     | 
/sbin/init     /lib/systemd/systemd 
^** CHECK FOR PERSISTENCE**^
```
### 4 PARTITION ENTRIES
### Hexadecimal 256,16,1
### 4 Bits represents a single Hex char

## Locate Hard drive and partition in linux
```
lsblk
```
## Examining the contents of the MBR with xxd
```
sudo xxd -l 512 -g 1 /dev/vda
```
## Making a copy of the MBR with dd 
```
dd if=/dev/vda of=MBRcopy bs=512 count=1
```
## GRUB
```
On BIOS Systems using MBR
Stage 1 : boot.img located in the first 440 bytes of the MBR loads…​

Stage 1.5 : core.img located in the MBR between the bootstrap and first partition. It loads…​

Stage 2 : /boot/grub/i386-pc/normal.mod which loads the grub menu and then reads
/boot/grub/grub.cfg Which displays a list of Linux kernels available to load on the system
````
````
Stage 1 : grubx64.efi Located on an EFI partition or in /boot loads…​

Stage 2 : /boot/grub/x86_64-efi/normal.mod /boot/grub/grub.cfg Which displays a list of Linux kernels available to load on the system
````
## Looking at Grub.cfg to find kernel 
```
cat /boot/grub/grub.cfg

** 
	This entry in /boot/grub/grub.cfg should be around line 107
```
## View inittab on SysV
```
cat /etc/inittab
ls -l /etc/rc*.d/ ** View specific rc 1,2,3,4,5,6
```
### Systemd target units are a set of value=data pairs to create processes in a set order on the system. But, they are simple to understand at a functional level by understanding the value=data fields within each
```
cat /lib/systemd/system/default.target | tail -n 8
```
### Service units create processes when called by target units. They, much like target units, have value=data pairs that determine what the unit does
```
cat /etc/systemd/system/display-manager.service | tail -n 13
```
### The /etc/environment file is part of PAM(Pluggable Authentication Modules) 6.6.1 used to authenticate users in Linux. That is why it isn’t a bash script like everything else. Executables not located in the path can not be executed by typing in the name of the executable, unless it is located in the same directory. Instead, the absolute or relative path to the executable must be given. ** CHECK FOR PERSISTENCE
```
cat /etc/environment
```
## /etc/profile file ** CHECK FOR PERSISTIENCE
```
cat /etc/profile

/etc/profile is a script that executes whenever a user logs into an interactive shell on Linux. its functionality depends entirely on the version of Linux being used. Ubuntu Linux uses it to set the BASH shell prompt by executing /etc/bash.bashrc and execute any script named *.sh in /etc/profile.d.

Unlike /etc/environment it executes every time a user logs in interactively; therefore, when the file is modified logging out then in again will apply the changes
```
## The .bash_profile and .bashrc files
sudo cat <profile>

## Values contain in hex positions 0x0000001 - 0x00000008
```
1B 2B 3B 4B 5B 6B 7B 8B 9B
eb 63 90 8e d0 31 e4 8e d8
0  1  2  3  4  5  6  7  8
```
## Hash first partition of MBR
```
dd if=/home/bombadil/mbroken bs=1 skip=446 count=16 | md5sum
** BS = blocksize
** Skip = skip # of bytes
** Count = Count # of bytes

0x0000 (0)      Bootstrap Code Area       446 Bytes
0x01BE (446)    Partition #1              16 Bytes
0x01CE (462)    Partition #2              16 Bytes
0x01DE (478)    Partition #3              16 Bytes
0x01EE (494)    Partition #4              16 Bytes
0x01FF (510)    0x55 BOOT SIG             2 Bytes
```
## OUTPUT HASH of GRUB from MBR
```
Find where GRUB BEGINS
xxd -l 393 -g 1 /home/bombadil/mbroken
** -l stop after length number
** -g number of octects per group

dd if=/home/bombadil/mbroken bs=1 skip=392 count=4 | md5sum
```
## Get Default run level of machine
```
cat /etc/inittab | grep def
```
## Identify the file that init is symbolically-linked to, on the SystemD init machine
```
cd /sbin
ls -lisa | grep init
```
## What is the default target on the SystemD machine and where is it actually located?
```
ls -lisa /lib/systemd/system/default.target
```
## Display configuration file for Default/Graphical target file
```
cat /lib/systemd/system/default.target | tail -n 8
OR
ls -l /etc/systemd/system/graphical.target.wants/
```
## How many wants dependencies does SystemD actually recognize for the default.target
```
systemctl show -p Wants graphical.target
```
## What is the full path to the binary used for standard message logging?
```
find / -name *syslogd* 2>/dev/null
```
## Identify the Linux Kernel being loaded by the Grub, by examining its configuration.
```
cat /boot/grub/grub.cfg | grep vmlinuz
```
# DAY7_LinuxProcessValidity

## htop
```
htop is a utility used to display various information about Linux processes dynamically, 
but in a more human friendly way
```
## Kernel Processes
```
init (/sbin/init) has a process ID of 1; and its parent, the Kernel has a PID of 0. The kernel starts /sbin/init which is the parent/grandparent of all user mode processes.

Modern Linux kernels/distros also have [kthreadd] which is a kernel thread daemon which is second after init so it will have a PID of 2 and will also have no parent.

All kernel processes are fork()ed from [kthreadd] and all user processes are fork()ed from /sbin/init or direct ancestor

Kernel processes are typically used to manage hardware, are directly handled by the kernel, have their own memory space, and have a high priority

Can be identified by the name enclosed in square brackets [ ] (using the ps -f option). kthreadd -spawned processes will have a PPID of 2

    For user-space processes /sbin/init ( PID = 1 )

    For kernel-space processes [kthreadd] ( PID = 2 )
```

## Process Ownership
### Effective User ID (EUID)
```
Effective user ID (EUID) defines the access rights for a process. In layman’s term it describes the user whose file access permissions are used by the process.
```
### Real User ID (RUID)
```
The real user ID is who you really are (the one who owns the process). It also defines the user that can interact with the running process—most significantly, which user can kill and send signals to a process.
```

## Process Enum
```
View kthreadd processes
ps --ppid 2 -lf | head
```
## Check status/start/stop/restart a service on sysV
```
service <servicename> status/start/stop/restart
```
## List all unit files that systemd has listed as active
```
systemctl list-units
```
## List all units that systemd has loaded or attempted to load into memory, including those that are not currently active, add the --all switch:
```
systemctl list-units --all
```
## Check status of a service
```
systemctl status <servicename.service>
```
# CRON JOBS ** Check for persistence
```
The cron daemon checks the directories /var/spool/cron, /etc/cron.d and the file /etc/crontab, once a minute and executes any commands specified that match the time.
/var/spool/cron     /etc/cron.d        /etc/crontab
```
## crontab commands
```
crontab -u [user] file This command will load the crontab data from the specified file
crontab -l -u [user] This command will display/list user’s crontab contents
crontab -r -u [user] This Command will remove user’s crontab contents
crontab -e -u [user] This command will edit user’s crontab contents
```
## crontab 
## minute hour day month week
```
  ┌───────────── minute (0 - 59)
  │ ┌───────────── hour (0 - 23)
  │ │ ┌───────────── day of the month (1 - 31)
  │ │ │ ┌───────────── month (1 - 12)
  │ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday;
  │ │ │ │ │                           7 is also Sunday on some systems)
  │ │ │ │ │
  │ │ │ │ │
  * * * * * <Time/Day to execute    "Command to Execute"
```
## Processes
### Viewing File Descriptors
```
List all open files being used by every process.
sudo lsof | tail -30

List all open files for a specific process
sudo lsof -c sshd

List all the proc directories.
ls -l /proc/
sudo ls -l /proc/14139
```
## Locate the strange open port on the SysV system
```
sudo lsof -i
sudo lsof -i :6969
```
## See what file/executable is related to a specific PID
```
ps -p <PID> -f
```
## Navigating Proc Directory to find a symbolically linked file via pid
```
List all the proc directories.
ls -l /proc/

Grab the PID of a process.
ps -elf | grep sshd

List contents for that PID directory.
sudo ls -l /proc/14139


lrwxrwxrwx 1 root    root    0 Aug 27 14:22 exe -> /usr/sbin/sshd
```
# CHECK /ETC/INNITTAB FOR PERSISTENCE ** 
# CHECK CRONJOBS FOR PERSISTENCE

## FIND EVIL ** FIND PERSISTENCE
```
**view system timers - systemctl list-timers
** crontjobs - ls -lisa /etc/cron.*
** Check for sus process - ps -elf, HTOP, TOP
** Check for files that reference .txt within -  grep -Rnw / -e "*.txt" 2>/dev/null
** Check startup scripts, profiles, ~/.bash_profile, ~/.bash_login, ~/.profile, /etc/profile
```
##  log Daemon
```
In most Linux systems, logging is controlled by syslog or journald.

Syslog stores its logs as human-readable text documents within /var/log. It is configured using files in /etc/rsyslog/

cat /etc/rsyslog.d/50-default.conf

cat /var/log/syslog ** filter usin cat vi and grep
```
** vim and zcat will read zip files without extracting them.
## System
```
/var/log/messages - Legacy Catch all
/var/log/syslog - Ubuntu/Debian Catch all
dmesg = Device Messenger (queires /proc/kmsg)

Kernel Ring Buffer - Never fills

First logs generated by the system

    Location: All logs are in /var, most are in /var/log

    Config File: /etc/rsyslog.conf

    Service: /usr/sbin/rsyslogd
```
## Parse all IP address from XML file using xpath and MD5Sum
```
xpath -q -e '//address/@addr' output.xml | md5sum

Multiple Elements

xpath -q -e '//address/@addr | //port/@portid' output.xml | md5sum
```
## Pretty Print JSON conn.log
```
xpath -q -e '//address/@addr' output.xml | md5sum
```
## Locate and Count the Unique originating IPs in Zeek(Bro)Log conn.log
```
jq . conn.log | grep orig_h | sort -u | wc -l
```
## Use jq to locate and count connections where the destination IP sent more than 40 bytes to the source IP.
```
jq -r 'select(.resp_bytes > 40)' conn.log | grep resp_bytes | wc -l
```

# Test Review
```
Peristence **
Linux has profiles, bachrc_.
Check cronjobs
Pay ATTENTION to Privileges** 
Execute means you can move into it, if it does not have execute bit set on the directory you can still look into it via "ls -l" or "sudo"
SUID bit allows you to run something temporarily as the the owner
Sticky bit is typically used for share directories
Zombie is program that is waiting for the parent
Orphan is a child process whose parent has exited 
Daemons can be used as a method of persistence
Systemctl status <service>

Linux Log
var/log/messages
/etc/rsyslog.conf
Use "strings" to evaluate system binaries/binaries

Running Processes - HTOP
Pay attention to process names, PIDs
Duplicate Process Names
High PIDs or even PPID for "system" level processes  ** Meant to have low PID/PPID

Run levels and /etc/inittab
cat /etc/inittab
ls -l /etc/rc*.d/

Check Profiles
cat /etc/profile
The .bash_profile and .bashrc files
sudo cat <profile>
