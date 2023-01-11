<#
param(
    [string] $environmentName = "",
    [bool] $reuseExistingEnvironment,
    [switch] $fromVSCode
)
#>

<#
$a=(wmic OS Get localdatetime)[2]
$b=$a.Substring(0,8) # Get the yyyyMMdd part
$c=$a.Substring(8,6) # Get the HHmmss part
$Year=$b.substring(0,4)
$Month=$b.substring(4,2)
$Day=$b.substring(6,2)
$Hour=$c.substring(0,2)
$Minute=$c.substring(2,2)
$Second=$c.substring(4,2)
#$today=get-date -Year $Year -Month $Month -Day $Day -Hour $Hour -Minute $Minute -Second $Second
$today=$year+"/"+$month+"/"+$day+" "+$hour+":"+$Minute+":"+$Second
#>

C:\DevOps\AlGo001\.AL-Go\cloudDevEnv.ps1 -environmentName QA -reuseExistingEnvironment Yes
# Senario 3
# https://github.com/microsoft/AL-Go/blob/main/Scenarios/RegisterSandboxEnvironment.md
# QA
# Deploy to Env => No Company