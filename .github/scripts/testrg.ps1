$rgset=@{
Name= 'ToyWebsiteTest'
Location= 'westus'
}
$appid=$testApplicationRegistration.AppId
$RoleDefinitionName = 'Contributor'
$testResourceGroup = New-AzResourceGroup @rgset -Force

New-AzADServicePrincipal -AppId $appid -Description "$appname is now configured in 
$(Get-Date -Format 'dd-MMM-yyyy, HH:mm:ss')"

$roleset=@{
    ApplicationId = $appid
    RoleDefinitionName = $RoleDefinitionName
    Scope = $testResourceGroup.ResourceId
    Description = "$RoleDefinitionName role is now configured in $(Get-Date -Format 'dd-MMM-yyyy, HH:mm:ss')"
}

New-AzRoleAssignment @roleset