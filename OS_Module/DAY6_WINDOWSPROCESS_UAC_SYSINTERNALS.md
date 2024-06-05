# DAY6_WINDOWSPROCESS_UAC_SYSINTERNALS
### **CHECK SERVICES FOR PERSISTENCE
## Commands to check processes
```
Get-Ciminstance Win32_Process
Get-Process
tasklist /svc
```
## Display modules/dlls associated to a specific process
```
tasklist /m /fi "IMAGENAME eq chrome.exe
```
## Specific string/process
```
tasklist /fi "IMAGENAME eq lsass.exe
```
## How to view services 
```
POWERSHELL
Get-Ciminstance
Get-Service

CMD
net start
sc query
sc queryex type=service
sc queryex type=service state=inactive
```
## View only system services and display Name, PID, and the path they are initiated from
```
Get-Ciminstance Win32_service | Select Name, Processid, Pathname | more | ft -wrap
```
## Display only currently running services
```
Get-Service | Where-Object {$_.Status -eq "Running"}
```
## View services in GUI
```
services.msc
OR
PsService
```
## View Schedtasks in PS
```
Get-ScheduledTask
Get-ScheduledTask | Select * | select -First 1
```
## View Schedtasks in CMD ** More INFO
```
schtasks /query /tn "MySchedTASK" /v /fo lis
```
### Decode encoded strings with CyberChef

## Autorun Registry locations 
```
Registry Keys Locations, Locations connected with Services
- HKLM\Software\Microsoft\Windows\CurrentVersion\Run - Local Machine
- HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
- HKLM\System\CurrentControlSet\Services
Remember that the Users have individual Hives with autoruns as well as the Current User.
- HKCU\Software\Microsoft\Windows\CurrentVersion\Run - Current User
- HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce
- HKU\<sid>\Software\Microsoft\Windows\CurrentVersion\Run - Specific User
- HKU\<sid>\Software\Microsoft\Windows\CurrentVersion\RunOnce
```
## Confirm a Sevices exists and View properties
```
CMD
schtasks /query | select-string -pattern IchBinBosh -Context 2,4

PS
Get-ScheduledTask | Select * | select-string -pattern IchBinBosh -Context 2,4
```
## View Network connections in cmd
```
netstat
-a   Displays all connections and listening ports
-n   Displays addresses and port numbers in numerical form
-o   Displays the owning process ID (PID) associated with each connection
-b   Displays the executable involved in creating each connection (must have admin rights)
```
# Baseline/Abnormalites
### System Processes run from C:\Windows\System32
### Third party processes will run elsewhere. Ex: Chrome runs from C:\Program Files
### System process with a high PID (System processes will be started first = Low PID)

# UAC
```
Multiple color-coded consent prompts

    Red - Application or publisher blocked by group policy

    Blue & gold - Administrative application

    Blue - Trusted and Authenticode signed application

    Yellow - Unsigned or signed but not trusted application
```
### Recursively Search for a registry key in a HIVE
```
reg query HKCU /s /f SERVICE
```

# SYSINTERNALS
## Process Monitor
```
Process Monitor is an advanced monitoring tool for Windows that shows real-time File System, Registry and Process/Thread activity. It combines the features of two legacy Sysinternals utilities, Filemon and Regmon

Registry - Anything from creating, reading, deleting, or querying keys

File System - File creation, writing, deleting, etc and this includes both local and      network drives

Network - This only shows source and destination TCP/UDP traffic

Process - These events are for processes and threads where a process starts, a thread starts or exits, etc. Probably better in ProcExp

Profiling - Checks the amount of processor time and memory use of each process
```
## AutoRuns
```
Autoruns shows applications automatically started on during system boot or login as well as the Registry and file system locations for auto-start configurations. Examples: AppInit, Winlogon, Scheduled Tasks, Services, Logon, etc.
```
## Search Registry for path and name of malware
```
Regedit.exe
```
## Find which process is sending the SYN_SENT flag
```
Use TCPView in SysInternals
Highlighted items that are colors notate special meanings
Pink - Means no publisher information was found or the digital signature doesn’t exist or match.
Green - Used when comparing previous set of Autorun data to indicate an item wasn’t there last time.
Yellow - The startup entry is there, but the file or job it points to doesn’t exist anymore
```
## What permissions are on an executable
```
Find Location/Directory of exe
Use accesschk on file
accesschk C:\PATH\MALWARE.exe -accepteula
```
## Get Path from handle on an executable
```
Find path/pid or use name of exe
RUN AS ADMIN
handle malware.exe -accepteula
```
## LoadOrder
```
Windows Firewall sevice mpssvc
Use LoadOrder to see Group
```
## See what dll is associated with a process
```
open Procexp as ADMIN
Find Process and view properties
View threads and somethingdll.dll should be in there
```
## View Public profile for Windows Defender Firewall
```
netsh advfirewall show publicprofile logging
```
## Determine what opened sus port 6666
```
Using tcp view discovered powershell.exe opened port 6666
An executable/ps script opened the port
use process explorer filtering for powershell.exe
View Command line in properties or hover over name of powershell.exe
```
## What Sysinternals tool will allow you to view a file's manifest?
```
SigCheck
```
```
./sigcheck -m C:\windows\regedit.exe
```
## Reg Query to see UAC 
```
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
```
## Provide the name of the UAC [Registry subkey] property that determines what level UAC is set to for admin privileges
```
ConsentPromptBehaviorAdmin    REG_DWORD    0x5
```
## Determine which UAC subkey property shows whether UAC is enabled or not.
```
EnableLUA    REG_DWORD    0x1337
```
##
