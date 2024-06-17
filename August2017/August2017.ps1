#Each scripting language has several different methods of applying the loop. PowerShell also support some universal loop like:

#ForEach-Object
#The simplest and most useful loop is foreach. This loop performs an operation for each input objects. For example:

$array = 1,2,3,4,5
$array | ForEach {Write-Host $_}

#Or

ForEach ($value in $array) {
    Write-Host $value
}

#For
#For loop is a standard loop to execute a specific number of times.

For ($i = 1; $i -lt 5; $i++)  {
    Write-Host $i
}

#While
#Next loop is while.  The While statement performs an operation until the condition is true.

$i = 1
While ($i -lt 5) {
    Write-Host $i; $i++
}

#While loop can be used in several different variants: do while and do until.
#Do while
#Do while executes as long as the condition is true but the first time it always executes.

$i = 1
do {
    Write-Host $i; $i++
}
while ($i -lt 5)

#Do Until
#Do until works almost the same as do while but it executes until the condition is not true.

$i = 1
do {
    Write-Host $i; $i++
}
until ($i -gt 5)

#For a complete set of examples, scenarios and commentary regarding loops in PowerShell, please visit this site Jump  or use cmdlet Get-Help:
#Get-Help about_Foreach
#Get-Help about_For
#Get-Help about_While
#Get-Help about_do