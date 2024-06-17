# PSGraph
# Written by Kevin Marquette
# GitHub - https://github.com/KevinMarquette/PSGraph

# Install GraphViz from the Chocolatey repo
Find-Package graphviz | Install-Package -ForceBootstrap

# Install PSGraph from the Powershell Gallery
Find-Module PSGraph | Install-Module

# Import Module
Import-Module PSGraph

#EXAMPLES

# *** Server Farm ***
# Server counts
$WebServerCount = 3
$APIServerCount = 2
$DatabaseServerCount = 4

# Server lists
$WebServer = 1..$WebServerCount | % {"Web_$_"}
$APIServer = 1..$APIServerCount | % {"API_$_"}
$DatabaseServer = 1..$DatabaseServerCount | % {"DB_$_"}

graph servers {
    node -Default @{shape='box'}
    edge LoadBalancer -To $WebServer
    edge $WebServer -To $APIServer
    edge $APIServer -To AvailabilityGroup
    edge AvailabilityGroup -To $DatabaseServer
} | Export-PSGraph -ShowGraph 

# *** DB Schema ***
$product = [ordered]@{
    ProductName = 'Sandbox'
    ProductID = 'P4576'
    CategoryID = 'C728'
    Description = 'Tractor tire with sand'
}

$Category = [ordered]@{
    CategoryID = 'C728'
    CategoryName = 'Backyard'
}

$OrderDetail = [ordered]@{
    OrderID = 'O3294'
    ProductID = 'P4576'
    UnitPrice = 280.00
    Quantity = 1
}

$Order = [ordered]@{
    OrderID = 'O3294'
    CustomerID = 'C1034'
    Address = '123 Street, Irvine CA'
}

Graph @{rankdir='LR'} {

    Entity $Product -Name Product
    Entity $Category -Name Category
    Entity $OrderDetail -Name OrderDetail
    Entity $Order -Name Order

    Edge Product:CategoryID -to Category:CategoryID
    Edge OrderDetail:OrderID -to Order:OrderID
    Edge OrderDetail:ProductID -to Product:ProductID

} | Show-PSGraph

# *** Network Connections by Process ***
$netstat = Get-NetTCPConnection | where LocalAddress -EQ '10.9.193.94'
$process = Get-Process | where id -in $netstat.OwningProcess

graph network @{rankdir='LR'}  {
    node @{shape='rect'}
    node $process -NodeScript {$_.ID} @{label={$_.ProcessName}}
    edge $netstat -FromScript {$_.OwningProcess} -ToScript {$_.RemoteAddress} @{label={'{0}:{1}' -f $_.LocalPort,$_.RemotePort}}
} | Export-PSGraph -ShowGraph