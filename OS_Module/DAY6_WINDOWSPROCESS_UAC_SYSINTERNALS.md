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
