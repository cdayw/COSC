# OS MODULE NOTES 
## INFO
```
CODA-M-24-503
Stack  10.50.36.172
OS_ACT  10.50.22.197:8000
xfreerdp /u:student /v:10.50.36.172 -dynamic-resolution +glyph-cache +clipboard
```
## DAY 1 - POWERSHELL 

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
