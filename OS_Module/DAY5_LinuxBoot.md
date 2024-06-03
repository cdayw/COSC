# DAY 5 LINUX BOOT

## BOOT PROCESS
```
BIOS              UEFI
MBR               GPT
GRUB              GRUB.efi
      LINUX KERNEL
          init
Sysv INIT         Systemd init 
/sbin/init        /lib/systemd/systemd 
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
