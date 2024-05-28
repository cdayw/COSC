# OS MODULE NOTES 
## INFO
```
CODA-M-24-503
Stack  10.50.36.172
OS_ACT  10.50.22.197:8000
xfreerdp /u:student /v:10.50.36.172 -dynamic-resolution +glyph-cache +clipboard
```
## DAY 1 - POWERSHELL 
```
01 : windows_powershell : start7917
02 : windows_powershell_profiles : start9943 
```
### Profiles - Method to set Persistence
```
$Profile

All Users, All Hosts         $PsHome\Profile.ps1 (Takes Precedence)
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
