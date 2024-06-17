#P2EXE - https://gallery.technet.microsoft.com/PS2EXE-GUI-Convert-e7cb69d5
# H:\Codevault\PoSH\PS2EXE-GUI

# Importing data into PowerShell
# Text Files

$checkhosts = Get-Content $env:windir\system32\drivers\etc\hosts

$ipaddresses = $checkhosts -match '^\d.*'

foreach ($ipaddress in $ipaddresses) {
    $ip = $ipaddress.split()
    if (test-port $ip[0]) {
        write-host "$ip is valid" -ForegroundColor Green
    }
    else {
        write-host "$ip is not valid" -ForegroundColor Red
    }
}

# CSV Files

$header = "Application","Title"
$apps = Import-Csv C:\temp\xaappTitle_07-27-2017_15-57.csv -Header $header
$apps | Get-Member
$apps | Format-Table
$apps | Select-Object Application -Unique
$apps | Select-Object Title -Unique

#CLIXML Files
#CliXML files in PowerShell are a special type of XML file that represent object(s) that have been exported.
#This is extremely handy when you need to export an object that you'll later want to import into PowerShell.  
#You are also able to export information as CliXML that contains credentials, securely. 
#Using CliXML is the best way to export/import objects that you are going to use directly in PowerShell.

get-process | Export-Clixml c:\temp\processes.xml
$processes2 = Import-Clixml C:\temp\processes2.xml
$processes2 | get-member