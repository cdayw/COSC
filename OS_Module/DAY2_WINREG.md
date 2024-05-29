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
## Get SIDS in powershell
```
Get-WmiObject win32_useraccount | select-object sid  
```
