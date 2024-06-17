# Add Scheudled jobs to you powershell toolbox
# https://jdhitsolutions.com/blog

# PowerShell Task Manager cmdlets make it easier
# Intro'd in PS3
# Managed from the prompt
# TaskScheduler runs it, so no PS required
# Jobs and results maintained from PS
# These are separate cmdlets from the Task Scheduler cmdlets
# How
    # Define job trigger
    # Define an action
    # Define options
    # Register the scheudled job
    # Manage persistent job results from PS
    # Job results are persistent when using Scheduled jobs
    # Disable/Enable
    # Unregister scheduled job
    # WINDOWS ONLY

get-command -module pscheduledjob

get-help New-JobTrigger

$trigger = New-JobTrigger -Daily -at 8:00AM

$name = "Dmain controller Service Check"

$action = {
    $services = 'DNS', 'NTDS'
}

# By default 32 job results are stored
# maxhistorycount
get-help get-scheduledjob

# passthru - some cmdlets do not output anything to cmdline. using 
# passthru will put something on the cmdline
# example stop-service bits
#           stop-service bits -passthru

# get-job
# get-scheduled job

# start-job -definition name

# argumentlist - put argument list in an explict array
# initializationscript - script block that will run prior to triggered job
# schedule jobs don't load powershell profile

#check out scriptblock, if you change it, it requires reenter credentials

help about_scheduled

#install-module scheduledjobtools
#https://github.com/jdhitsolutions/scheduledjobtools
#export
#import
#get job result
#remove old job results

