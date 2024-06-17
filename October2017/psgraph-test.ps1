#PSGraph
# If running from Server - Install Desktop Experience Feature

# http://psgraph.readthedocs.io/en/latest/Quick-Start-Installation-and-Example/
# Install GraphViz from the Chocolatey repo
Register-PackageSource -Name Chocolatey -ProviderName Chocolatey -Location http://chocolatey.org/api/v2/
Find-Package graphviz | Install-Package -ForceBootstrap

# Install PSGraph from the Powershell Gallery
Find-Module PSGraph | Install-Module

#Generating your first graph
#PSGraph has a unique syntax for defining a graph. This is because it was built specifically for the GraphViz engine. Here is a basic graph to get you started.

# Import Module
Import-Module PSGraph

graph "myGraph" {
    edge start, middle, end        
} | Export-PSGraph -ShowGraph

#graph, edge, node Example
graph g @{rankdir = 'LR'} {
    node a @{label = 'Node'}
    node b  @{label = 'Node'}
    edge -from a -to b @{label = 'Edge'}
} | Export-PSGraph -ShowGraph 

#Example: Project flow
graph g {
    node -default @{shape = 'rectangle'}
    node git @{label = "Local git repo"; shape = 'folder'}
    node github @{label = "GitHub.com \\master"}

    edge git, github, AppVeyor.com, PowershellGallery.com
    edge github -to ReadTheDocs.com
} | Export-PSGraph -ShowGraph 

#Example: A more detailed project flow
graph g {
    node -default @{shape='rectangle'}
    node git @{label="Local git repo";shape='folder'}
    node github @{label="GitHub.com \\master";style='filled'}

    edge VSCode -to git @{label='  git commit'}
    edge git -To github @{label='  git push'}
    edge github -To AppVeyor.com,ReadTheDocs.com  @{label=' trigger';style='dotted'}
    edge AppVeyor.com -to PowershellGallery.com @{label='  build/publish'}
    edge ReadTheDocs.com -to psgraph.readthedocs.io @{label='  publish'}
} | Export-PSGraph -ShowGraph

# Example: Server farm
# Server counts
$WebServerCount = 2
$APIServerCount = 2
$DatabaseServerCount = 2

# Server lists
$WebServer = 1..$WebServerCount | % {"Web_$_"}
$APIServer = 1..$APIServerCount | % {"API_$_"}
$DatabaseServer = 1..$DatabaseServerCount | % {"DB_$_"}

graph servers {
    node -Default @{shape = 'box'}
    edge LoadBalancer -To $WebServer
    edge $WebServer -To $APIServer
    edge $APIServer -To AvailabilityGroup
    edge AvailabilityGroup -To $DatabaseServer
} | Export-PSGraph -ShowGraph 

# WEM Infrastructure
$WEMServerHillsCount = 1
$WEMServerWadeCount = 1
#$DatabaseServerCount = 1

$WEMServerHills = 0..$WEMServerHillsCount | % {"CWEM0990$_"+"V"}
$WEMServerWade = 0..$WEMServerWadeCount | % {"PWEM0990$_"+"V"}
$DatabaseServer = "PEDB0314"
$DatabaseBKServer = "CEDB0314"
$DBName = "P_WADE_WEM_01"
