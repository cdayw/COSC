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
## Check status/start/stop/restart a service on sys
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
