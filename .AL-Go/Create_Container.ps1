#Param(
#    [string] $containerName = "",
#    [string] $auth = "",
#    [pscredential] $credential = $null,
#    [string] $licenseFileUrl = "",
#    [string] $insiderSasToken = "",
#    [switch] $fromVSCode
#)

#Start-Transcript
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

$username1 = "test"
$password1 = ConvertTo-SecureString "Password2023" -AsPlainText -Force
$credNAV = New-Object System.Management.Automation.PSCredential -ArgumentList ($username1, $password1)

$basePath = $env:USERPROFILE # Path were the license files are
$licenseFiles = Get-ChildItem -Path (join-path $basePath ".docker\*.flf")
foreach ($licenseFile in $licenseFiles) {
    $licExp = (Select-String -Path $licenseFile -Pattern "Expires").ToString()
    [datetime]$licExpDate = $licExp.Substring($licExp.LastIndexOf(":")+2)
        if ($licExpDate -gt $today) {
        $licenseFileName = $licenseFile.FullName
        $expDate = $licExpDate.ToLongDateString()
		write-host -ForegroundColor Yellow [licExpDate=$licExpDate][today=$today][isValid=$isValid][licenseFileName=$licenseFileName]
    } else {
        $expPath = join-path $basePath ".docker\Expired"
        if (!(Test-Path -Path $expPath)) { mkdir $expPath }
        Move-Item $licenseFile -Destination $expPath
    }
}

if ($null -eq $licenseFileName){
    Write-Host -ForegroundColor Red No Valid Licences Found. Aborting...
#    Stop-Transcript
    exit
} else {
    Write-Host -ForegroundColor Green Using [$licenseFileName] expiring on [$expdate]
}

$contName = "AlGoTest001"

.\localDevEnv.ps1 -containerName $contName -auth UserPassword -credential $credNAV -licenseFileUrl $licenseFileName
#Stop-Transcript

# Senario 8
# https://github.com/microsoft/AL-Go/blob/main/Scenarios/CreateOnlineDevEnv.md
# ERPS-Sandbox