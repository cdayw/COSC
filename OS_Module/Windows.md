# WINDOWS
*** https://hadess.io/the-art-of-windows-persistence/
## INFO
```
CODA-M-24-503
Stack  10.50.36.172
OS_ACT  10.50.22.197:8000
xfreerdp /u:student /v:10.50.36.172 -dynamic-resolution +glyph-cache +clipboard
```
# IMPORTANT** CHECK SERVICES FOR PERSISTENCE services.msc
```
### Profiles - Method to set Persistence
```
$Profile
```
All Users, All Hosts         $PsHome\Profile.ps1 (Takes Precedence #Runs on Startup)
All Users, Current Host      $PsHome\Microsoft.PowerShell_profile.ps1
Current User, All Hosts      $Home\[My]Documents\Profile.ps1
Current User, Current Host   $Home\[My ]Documents\WindowsPowerShell\Profile.ps1
```


### Create a transcript to record commands ran
```
Start-Transcript C:\MyWork.txt                   # Starts to log commands into the c:\mywork.txt file
Get-Service                                      # Run get-service command and inputs that and the results into the transcript.
Stop-Transcript                                  # End the transcript
notepad c:\MyWork.txt                            # View the contents of the created transcript
```
## See Perms
```
Get-PSSessionConfiguration                        # Displays permissions
```

## Get a Process information/description 
```
Get-Ciminstance -Class Win32_Service | Where-Object name -like PROCESSNAME | Fl *
```

## Count Number of words in a txt file
```
Get-Content words2.txt | measure-object -word
```
## Count Number of files in a directory 
```
gci | measure-object -line
```
## Compare two text files and find differences
```
compare-object (get-content .\new.txt) (Get-Content .\old.txt)
```
## Get number of methods of Get-Process command and count each line to get total
```
Get-Process | Get-member -MemberType Method | Measure-Object -Line
```
## Count Number of Files in a directory
```
gci | Measure-Object -Line
```
## Count the number of words, case-insensitive, with either a or z in a word, in the words.txt file
```
Get-Content words.txt | Select-String -Pattern a,z | Measure-Object -Line
```
## Use a PowerShell loop to unzip the Omega file 1,000 times and read what is inside.
```
$a = 1001
PS C:\Users\CTF\Documents> DO {$a-- 
>> Expand-Archive -Path C:\Users\CTF\Documents\Omega$a.zip -DestinationPath C:\Users\CTF\Documents
>> }Until ($a -eq 0)
```
## Count the number of words in words.txt that meet the following criteria: a twice, and have A-G immediately after
```
gci .\words.txt | Select-String -Pattern 'a{2,}[a-g]' | Measure-Object -Word
```
## View primary powershell profile
```
cat $PsHome\Profile.ps1 
```
## Get User and SID
```
Get-LocalUser | select Name,SID
```
## UserAssist
```
The UserAssist registry key tracks the GUI-based programs that were ran by a particular user
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist\{GUID}\Count\
*** they are encoded in ROT13
CEBFF5CD-ACE2-4F4F-9178-9926F41749EA A list of applications, files, links, and other objects that have been accessed
F4E57C4B-2036-45F0-A9AB-443BCFE33D9F Lists the Shortcut Links used to start programs
```
```
Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist\{CEBFF5CD-ACE2-4F4F-9178-9926F41749EA}\Count"
Output shows the Executable files encoded with ROT13. Copy/ Paste the output into a decdoer site like Rot13 or CyberChef
```
# DAY 2 windows registry and windows alternate data stream
Cheat Sheets - https://training.13cubed.com/downloads
## SID
```
S-1-5-18 refers to LocalSystem account.

S-1-5-19 refers to LocalService account. It is used to run local services that do not require LocalSystem account.

S-1-5-20 refers to NetworkService account. It is used to run network services that do not require LocalSystem account.

S-1-5-21-domain-500 Refers to the built in local administrator account. 
```
## Registry Structure
```
HKLM\SAM                SAM, SAM.LOG
HKLM\SECURITY           SECURITY, SECURITY.LOG
HKLM\SOFTWARE           Software, software.LOG, software.sav
HKLM\SYSTEM             System, system.LOG, system.sav
HKLM\HARDWARE           Dynamic/Volatile Hive
HKU\.DEFAULT            Default, default.LOG, default.sav
HKU\SID                 NTUSER.DAT
HKU\SID_CLASSES         UsrClass.dat, UsrClass.dat.LOG
```
```
Presently, the path for the registry for Service DLL is:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Service_Name\Parameters\ServiceDll
```
## Powershell to get mapped drives
```
Get-PSDrive
```
## Get-Item - Reads the value of the inputted object
```
Get-item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
```
## Get-ChildItem - Reads sub keys from the input value
```
Get-ChildItem HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\
```
## Get USER/SIDS in powershell
```
Get-WmiObject win32_account | select-object name,sid | fl
```
## What is the value inside of the registry subkey that loads a single time when the "student" user logs on?
```
get-item registry::HKEY_USERS\S-1-5-21-2881336348-3190591231-4063445930-1003\Software\Microsoft\Windows\CurrentVersion\Runonce
```
## Run Once everytime Machine is powered on
```
gi registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce 
```
## Figure out the manufacturer's name of the only USB drive that was plugged into this machine.
```
get-item registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR
```
## What suspicious user profile, found in the registry, has connected to this machine?
```
gci ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList’
```
## What suspicious wireless network, found in the registry, has this system connected to?
```
gci registry::"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Networklist\Profiles"
```
## Get File Permissions 
```
Get-Acl
```
## Find a file and ignore errors
```
gci C:\readme -Recurse -Force -ErrorAction SilentlyContinue
```
## Find Hidden Files and Identify ADS
```
gci -path C:\Users\CTF\Documents -force -recurse
gi .\nothing_here -Stream *
gc .\nothing_here:hidden
```
## Find any file with fortune in name, Identiy ADS and read
```
gci C:\*fortune* -force -recurse -ErrorAction SilentlyContinue
gi '.\The Fortune Cookie' -stream *
gc '.\The Fortune Cookie' -Stream none
```

# BIOS OR UEFI
```
bcdedit | findstr /i winload 
```
## Delete Safeboot value
```
bcdedit /deletevalue safeboot 
```
# IMPORTANT** CHECK SERVICES FOR PERSISTENCE services.msc

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
## What command-line (cmd) command will show service information?
```
sc query
```
# BAM
## BAM entries for every user on the system
```
Get-Item HKLM:\SYSTEM\CurrentControlSet\Services\bam\state\UserSettings\*
```
## Single User on the System
```
wmic useraccount  get caption,sid | more
Get-Itemproperty 'HKLM:\SYSTEM\CurrentControlSet\Services\bam\State\UserSettings\S-1-5-21-1584283910-3275287195-1754958050-1005'
```
## Recycle bin artifacts
```
Find the Contents of the Recycle Bin
Get-Childitem 'C:\$RECYCLE.BIN' -Recurse -Verbose -Force | select FullName

SID - determines which user deleted it

Timestamp - When it was deleted

$RXXXXXX - content of deleted files

$IXXXXXX - original PATH and name


(Hidden System Folder)
C:\$Recycle.bin
```
## Prefetch
```
Prefetch files are created by the windows operating system when an application is run from a specific location for the first time.

Location 
Win7/8/10
C:\Windows\Prefetch
```
## Recent Files
```
Registry Key that will track the last files and folders opened and is used to populate data in “Recent” menus of the Start menu. 
Tracks last 150 files or folders opened.

Location
HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs
HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.txt

Get-Item 'Registry::\HKEY_USERS\*\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.*'
Get-Item 'Registry::\HKEY_USERS\*\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.txt'

Converting a Single Value from Hex to Unicode
:Unicode.GetString((gp "REGISTRY::HKEY_USERS\*\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.txt")."0")
```
## Browser Artifacts 
```
Win7/8/10: %USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\history

"C:\Users\andy.dwyer\AppData\Local\Google\Chrome\User Data\Default\"
**  The location is different for every browser.

Z:\strings.exe 'C:\users\andy.dwyer\AppData\Local\Google\Chrome\User Data\Default\History' -accepteula

**** Alternatively the Select-String cmdlet can be used if Sysinternals is not available. 
```
## Powershell Artifacts 
```
powershell history of cmds
Get-History

C\Users\**username**\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
Use Get-Content to access the the history
Get-Content "C:\users\$env:**username**\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
```
## Get LastAccess time of file
```
Hosts File - C:\Windows\System32\drivers\etc
gci | select-object LastAccessTime,Name
```
## When reading logs, you may notice ... at the end of the line where the message is truncated. What format-table switch/argument will display the entire output?
```
Format-Table -Wrap
```
## Find File and get creation time
```
gci C:\ -Filter  BAD_INTENTIONS.EXE-8F2806FC.pf -ErrorAction SilentlyContinue -Recurse | select-object CreationTime
```
