## INFO
```
CODA-M-24-503
Stack  10.50.36.172
OS_ACT  10.50.22.197:8000
xfreerdp /u:student /v:10.50.36.172 -dynamic-resolution +glyph-cache +clipboard
```

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
