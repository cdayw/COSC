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

## cronjob
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
