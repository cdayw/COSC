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
```
