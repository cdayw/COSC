# PowerShell Notes
Student Guide - https://cted.cybbh.io/tech-college/pns/public/pns/latest/guides/ps_sg.html
## RDP command 
```
xfreerdp /u:student /v:1.x.x.x -dynamic-resolution +glyph-cache +clipboard
```
### Setting Variable
```
$var1 = 1
$var2 = 5
$var3 = 6

$var1 + $var2 + $var3

OUTPUT > 12
```
```
$false > False
$true > True

$_ or $PSItem > Object in current pipeline
$Matches > Hash Table of RegEx matches
$input > Enumerator that enumerates all input passed to a function
```
### Typecasting 
```
[string]$false + 'hello world'
[int]10
[float]2.0
[array]

([string]$false + 'hello world').GetType()

<Pull value name (Type) out of table>
([string]$false + 'hello world').GetType().name 

<Get-Member>
([string]$false + 'hello world').GetType().name | Get-Member
```
## Practical Exercises
### Find Cmdlets
```
Which cmdlets deal with the viewing/manipulating of processes?
Get-Process
Get-Process -Noun Process
Get-Process -Verb start

Display a list of services installed on your local computer.
Get-Service

What cmdlets are used to write or output objects or text to the screen?
Write-Host

What cmdlets can be used to create, modify, list, and delete variables?
Get-Variable
Remove-Variable
Set-Variable

What cmdlet can be used, other than Get-Help, to find and list other cmdlets?
Get-Command

Find the cmdlet that is used to prompt the user for input.
Read-host
```
### Running Cmdlets
```
Display a list of running processes.
Get-Process

Display a list of all running processes that start with the letter "s"
Get-Process s*

Find the cmdlet and its purpose for the following aliases:
gal -> Get-Alias
dir -> Get-ChildItem
echo -> Write-Output
? -> Where-Object
% -> ForEach-Object
ft -> Format-Table

Display a list of Windows Firewall Rules.
Get-NetFirewallRule
Show-NetFirewallRule

Create a new alias called "gh" for the cmdlet "Get-Help"
Set-Alias gh -Value Get-Help

```
### Variables 
```
'$var1' > $var1  (Literally prints string $var1)
"$var1" > 10     (prints whatever is assigned to var1)

Create a variable called "var1" that holds a random number between 25-50.
$var1 = Get-random -Minimum 25 -Maximum 51

Create a variable called "var2" that holds a random number between 1-10.
$var2 = Get-random -Minimum 1 -Maximum 11

Create a variable called "sum" that holds the sum of var1 and var2.
$sum = $var1 + $var2

Create a variable called "sub" that holds the difference of var1 and var2.
$sub = $var1 - $var2

Create a variable called "prod" that holds the product of var1 and var2.
$prod = $var1 * $var2

Create a variable called "quo" that holds the quotient of var1 and var2.
$quo = $var1 / $var2

Replace the variables in text with their values in the following format:
"$var1 + $var2 = $sum"

Replace the variables in text with their values in the following format:
"$var1 - $var2 = $sub"

Replace the variables in text with their values in the following format:
"$var1 * $var2 = $prod"

Replace the variables in text with their values in the following format:
"$var1 / $var2 = $quo"
```
### Creating an Array
```
$array = "gal", "dir", "echo", "?", "%", "ft"
$array | ForEach-Object{Get-Alias $_}

$var = "HELLO WORLD"
[array]$var[0..5]
H
E
L
L
O
```
## More Variables + & or Invoke-Command
```
$myblock = { Get-Service | Format-Table Name, Status }
&myblock or invoke-command $myblock         >       Will Run commands inside of {}

$b = {1+1}
&$b or invoke-command $b     >   2
```
## Sort-Object
```
Get-ChildItem | Sort-Object       >       Sorts Alphabetically
Get-ChildItem "C:\Users\student"| Sort-Object -Property Length -Descending  > Sorts Alphabetically based on length
```
### Group-Object
```
Get-Service | Group-Object status
Get-Process | Group-Object {$_.name}    >   sorts process alphabetically by name
Get-Process | Group-Object {$_.name.Substring(0,4)}   > same as above only shows four letters
Get-Process | Group-Object {$_.name.Substring(0,4).ToUpper()}    > same as above but shows uppercase
Get-Process | Group-Object {$_.name.Substring(0,1).ToUpper()} | ForEach-Object{($_.name + " ") * 1; "======"; $_.Group}
 ^    Groups Processes by first letter in process name and lists them
```
## Reverse Array from Random number range
```
$var1 = Get-Random (-20..0)
$var2 = Get-Random (0..20)
$array = [array]($var1..$var2)
Write-Host $array
[Array]::Reverse($array);
Write-Host $array
```
## From above script, Gives number of elements in Array
```
$array.Length
$reversed = $array[($array.Length-1)..0]
```
### Display the start time of the earliest and latest running processes
```
Get-Process | Where-Object{$_.StartTime} | Measure-Object -Property StartTime -Minimum -Maximum | Select-Object -Property Minimum, Maximum
```
### Get day of the wekk
```
Get-Date | select DayOfWeek
```
### Installed Hotfixed
```
Get-HotFix
```
## Display Hotfixes by Installed Date and ID 
```
Get-HotFix | Where-Object{$_.InstalledOn} | Sort-Object -Property InstalledOn | Select-Object -Property InstalledOn, HotFixID
```
## Sort by Description, Including Description HOTFIXID and Date
```
Get-HotFix | Where-Object{$_.InstalledOn} | Sort-Object -Property Description | Select-Object -Property Description, InstalledOn, HotFixID 
```
## Find and extract the model number from the provided lines of text. If there isn’t a model number then display to the user that a model number wasn’t found
```
$line1 = "Do you have model number: MT5437 for john.doe@sharklasers.com?"
$line2 = "What model number for john.doe@sharklasers.com?"

$pattern = "MT\d+"

foreach ($line in $line1, $line2){
if ($line -match $pattern){
    $matched = $Matches[0]
    $mod = Select-String $matched -Pattern "model number:*"
    Write-Output "$mod was found"

}
    else{
    Write-Host "serial not found in $line2"
    }
}

OR

$pattern = '[A-Z]{2}[0-9]{4}'

$line1,$line2 | ForEach-Object {
    if($_ -match $pattern){
    Write-Host $Matches[0]": $_"
    }
    else{
    Write-Host "no matches found on: $_"
    }
}

```
##  Use an array to iterate and open the following; Notepad, MS Edge, MSpaint. Query the processes, Kill the processes from PowerShell
```

```
## IF Statements
```
$x = 5
if ($x -lt 5) {
  Write-host "Less than 5"
} elseif ($x -eq 5) {
  Write-Host "It is 5"
} else {
  Write-Host "Greater then 5"
}
```
## Multiply integers in an array by two
```
$nums = 1,2,3,4,5
$nums.GetType()
$nums | ForEach-Object{$_ * 2}

OR

foreach($i in $nums){$i * 2}
```
## Change all elements in array to upper
```
$BB = "Mr. Krabs","Sandy","SpOngebOb","Patrick","Gary"

foreach($fish in $BB){$fish.toUpper()}
```
## Using -like to extract an element out of an Array
```
$BB = "Mr. Krabs","Sandy","SpOngebOb","Patrick","Gary"

foreach($fish in $BB){
    if($fish -like 'SPONGE*'){
        "$fish is the best fry cook"
        }
}
```
## Using -like to extract different elements out of an Array 
```
$BB = "Mr. Krabs","Sandy","Larry the Lobster","SpOngebOb","Patrick","Gary"

foreach($fish in $BB){
    if($fish -like 'SPONGE*'){
        "$fish is the best fry cook"
        }
    elseif($fish -like '*Lob*'){
        "$fish has the most gainz"
        }
    else{
    "$fish is cool"
    }
}
```
