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
$procs = "notepad","MSEdge","mspaint"

$procs | ForEach-Object { Start-Process $_ }


$file = "$pwd\procs.txt"
foreach($proc in $procs){
    Get-Process | Where-Object{$_.Name -like $proc} | `
    ForEach-Object{Add-Content $file $_.Id} }
Get-Content .\procs.txt | ForEach-Object{Stop-Process $_}

Foreach($proc in $procs){
     Get-Process | Where-Object{$_.Name -like $proc} | `
     Format-Table -Property id, name, starttime, totalprocessortime, `
     VirtualMemorySize, WorkingSet64
     }

$procs | ForEach-Object{Get-Process $_ | Select id, name, starttime, totalprocessortime, `
     VirtualMemorySize, WorkingSet64 | sort}

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
## Using -like to extract specific elements out of an Array 
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
## Using -match and regex to extract specific elements out of an Array
. -> wildcard in regex  /  '*' asterisk is quantifier in regex
```
$BB = "Mr. Krabs","Sandy","Larry the Lobster","SpOngebOb","Patrick","Gary"

foreach($fish in $BB){
    if($fish -match '^S.*b$*'){
        "$fish is the best fry cook"
        }
    elseif($fish -match '^L.*r$'){
        "$fish has the most gainz"
        }
    else{
    "$fish is cool"
    }
}
```
## Counting to 5 
```
$num = 0

while($num -lt 5){
    $num 
    $num++ 
}
```
## Magic Number game with random number
```
$num = 0
$magic = Get-random(0..200)

while($True){
    $num = Read-Host -Prompt "Pick a number between 0 and 200" 
    if ($num -lt $magic){
    "Too low, Try again"
    } 
    elseif($num -gt $magic){
    "Too high, Try again"
    }
    else{
    "Winner $magic"; break
    }
}
```
## Find processes that contain MS
```
Get-Proccess | Where-Object{$_.name -like "*MS*"}
```
## Split and Join 
```
<SPLIT>
foreach($oct in ('8.8.8.8' -split '\.')){     #\ escapes the .#
    if ([int]$oct -lt 0 -and [int]$oct -gt 255){
        "$oct is not valid octet"
        }
    else {"$oct is valid"}
}

<JOIN> #joins elements in an array
'cat','dog' -join ""
>catdog
```
## starswith and endswith (true/false)
```
'cat'.startswith('c')
'dog'.endswith('g')
```
## empty array
```
$empty = @()
```
## jagged array
```
$empty = (1,2,3,(4,5,6,(7,8,9)))

$empty[3][3][0]
> 7
```
## append to an array
```
$sum = 0
$sum += 1

$empty = @()
$empty += 1
$empty += $sum
$empty += 'cat'
```
# Elements provided on the pipeline {$_}
"begin, process, end. "begin and end are optional"
```
function cool-printer{ 
process{$_}
}
1,2,3,4,5 | cool-printer
> 1
> 2
> 3
> 4
> 5

OR


funcion Print-Input{
Process{Write-Output "$PSItem"}
}
```
# Elements provided on pipeline cont.
## Print Input from elements provided
```
function Print-Input{
Process{Write-Output "$PSItem"}
}
```
## Sum with Elements provided
```
function Get-Sum{
    begin{$sum = 0}

    process{$sum += $_}
 
    end{$sum}

}
1,2,3,4,5 | Get-Sum
> 15
```
## Print each element provided and sum
```
function Print-Input{
$sum = 0 
foreach($num in $input){
$num
$sum += $num}
$sum
}

1,2,3,4 | Print-Input
> 1
> 2
> 3
> 4
> 10
```
## Do/While/until
```
$num = 4
do { 
    $num
    $num ++
 }while($true)
```
## counts forever
```
$num = 4
do { 
    $num
    $num ++
 }while($true)
```
## counts to 3
```
$num = 0
do { 
    $num
    $num ++
 }until($num -gt 3)
```
# Practice Test
## Return the product of the arguments
```
$prod = $var1 * $var2 * $var3 *$var4
    return $prod
```
## Search the 2 dimensional array for the first occurance of key at column index 0 and return the value at column index 9 of the same row. Return -1 if the key is not found
```
$a = 0
    foreach ($i in $arr){
        if($i[0] -eq $key){
        return $i[9]}
    }
    if($a -eq 0){
        return -1
    }
```
## In a loop, prompt the user to enter positive integers one at time. Stop when the user enters a -1. Return the maximum positive value that was entered.
```
$vals = @()
   do {
       $val = Read-Host
       if ([int]$val -ne -1){
           $vals += $val
       }
    }until([int]$val -eq -1)
    return ($vals | Measure-Object -Maximum).Maximum
```
## Return the line of text from the file given by the `$filename argument that corresponds to the line number given by `$whichline. The first line in the file corresponds to line number 0.
```
Get-Content $filename | select-object -Index($whichline)
```
## Return the sum of all elements provided on the pipeline
```
$sum = 0
       foreach($num in $input){
            $sum += $num}
       return $sum    
```
## Return only those commands whose noun is process
```
Get-Command -noun 'process'
```
## Return the string 'PowerShell is ' followed by the adjective given by the `$adjective argument
```
return "Powershell is $adjective"
```
## Return `$true when the given argument is a valid IPv4 address, otherwise return `$false. For the purpose of this function, regard
addresses where all octets are in the range 0-255 inclusive to be valid.
```
foreach($oct in $addr -split '\.'){
        if ([int]$oct -gt 0 -and [int]$oct -lt 255){
            return $true}
        else{return $false}
       }
```
## Return `$true if the contents of the file given in the `$filepath argument have changed since `$lasthash was
computed. `$lasthash is the previously computed SHA256 hash (as a string) of the contents of the file.
```
$x = (Get-FileHash $filepath).hash
       if($x -ne $lasthash){
            return $true
        }
        else{
            return $false
        }
         
```
