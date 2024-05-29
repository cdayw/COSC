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
