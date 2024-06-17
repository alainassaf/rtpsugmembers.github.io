### http://mikefrobbins.com/2013/09/19/fun-and-games-with-powershell/
Add-Type -AssemblyName System.Speech
[int]$guess = 0
[int]$attempt = 0
[int]$number = Get-Random -Minimum 1 -Maximum 100
$voice = New-Object System.Speech.Synthesis.SpeechSynthesizer
$voice.Speak("Ahoy matey! I'm the Dreaded Pirate Robbins, and I have a secret!
              It's a number between 1 and 100. I'll give you 7 tries to guess it.")
do {
    $voice.SpeakAsync("What's your guess?") | Out-Null
    try {
        $guess = Read-Host "What's your guess?"
        if ($guess -lt 1 -or $guess -gt 100) {
            throw
        }
    }
    catch {
        $voice.Speak("Invalid number")
        continue
    }
    if ($guess -lt $number) {
        $voice.Speak("Too low, yee scurry dog!")
    }
    elseif ($guess -gt $number) {
        $voice.Speak("Too high, yee land lubber!")
    }
    $attempt += 1
}
until ($guess -eq $number -or $attempt -eq 7)
if ($guess -eq $number) {
    $voice.Speak("Avast! Yee guessed my secret number, yee did!")
}
else {
    $voice.Speak("Yee out of guesses! Better luck next time, yee matey!
                  My secret number was $number")
}

### https://blogs.technet.microsoft.com/heyscriptingguy/2014/03/30/understanding-streams-redirection-and-write-host-in-powershell/

function Write-Messages {
    [CmdletBinding()]
    param()   

    Write-Host "Host message"
    Write-Output "Output message"
    Write-Verbose "Verbose message"
    Write-Warning "Warning message"
    Write-Error "Error message"
    Write-Debug "Debug message"
}

 

# Writes all messages to console.

Write-Messages -Verbose -Debug

# Writes output to the file
# Writes all other messages to console.

Write-Messages -Verbose -Debug > .\OutputFile.txt

# Writes all output except Host messages to file

Write-Messages -Verbose -Debug *> .\OutputFile.txt

# Writes all output (except Host messages) to output stream, then saves them in a file.

Write-Messages -Verbose -Debug *>&1 | Out-File -FilePath .\OutputFile.txt

# Writes all messages to console and then saves all but host messages in a file.

Write-Messages -Verbose -Debug *>&1 | Tee-Object -FilePath .\OutputFile.txt


### https://devcentral.f5.com/articles/powershell-abcs-o-is-for-output

# Sends the output of a command in two directions (like the letter "T"). It stores the output in a file or variable and also sends it down the pipeline

get-process | tee-object -filepath .\OutputFile.txt -Append

notepad.exe 

get-process notepad | tee-object -variable proc | select-object processname,handles 

### https://blogs.technet.microsoft.com/heyscriptingguy/2013/06/20/how-to-use-powershell-to-write-to-event-logs/
#The Write-EventLog cmdlet writes an event to an event log.
new-eventlog -LogName Application -Source "Alain's Scripts"
write-eventlog -logname Application -source "Alain's Scripts" -eventID 3001 -entrytype Information -message "MyApp added a user-requested feature to the display." -category 1 -rawdata 10,20

### https://mohitgoyal.co/2017/04/20/enforce-prerequisites-match-before-running-powershell-scripts/
#Requires -Version <N>[.<n>]
#Requires -PSSnapin <PSSnapin-Name> [-Version <N>[.<n>]]
#Requires -Modules { <Module-Name> | <Hashtable> }
#Requires -ShellId <ShellId>
#Requires -RunAsAdministrator