$rgset=@{
Name= 'ToyWebsiteProduction'
Location= 'westus'
}
$appid=$productionApplicationRegistration.AppId

$productionResourceGroup = New-AzResourceGroup @rgset -Force

New-AzADServicePrincipal -AppId $appid -Description "$prodappname is now configured in 
$(Get-Date -Format 'dd-MMM-yyyy, HH:mm:ss')"

$roleset=@{
    ApplicationId = $appid
    RoleDefinitionName = 'Contributor'
    Scope = $productionResourceGroup.ResourceId
    Description = "$RoleDefinitionName role is now configured in $(Get-Date -Format 'dd-MMM-yyyy, HH:mm:ss')"
}

New-AzRoleAssignment @roleset