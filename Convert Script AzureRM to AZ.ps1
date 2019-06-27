#Original Script: https://bartsimons.me/convert-azurerm-scripts-to-az/

$Mappings = ((Invoke-WebRequest https://raw.githubusercontent.com/Azure/azure-powershell/master/src/Accounts/Accounts/AzureRmAlias/Mappings.json -UseBasicParsing).Content | ConvertFrom-Json)

$ScriptFile = "C:\scripts\script.ps1"
$Script = (Get-Content $ScriptFile -Raw)

($Mappings | Get-Member -MemberType NoteProperty) | % {
    $Mappings.$($_.Name) | % {
        ForEach ($Mapping in ($_ | Get-Member -MemberType NoteProperty)) {
            $Script = $Script -replace $_.$($Mapping.Name),$Mapping.Name
        }
    }
}

$Script | Set-Content $ScriptFile