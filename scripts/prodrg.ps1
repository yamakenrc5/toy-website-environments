$rgset = @{
    Name = 'ToyWebsiteProduction'
    Location = 'westus'
}

$appid = $productionApplicationRegistration.AppId
$RoleDefinitionName = 'Contributor'
$appname = $prodappname

$productionResourceGroup = New-AzResourceGroup @rgset -Force

New-AzADServicePrincipal -AppId $appid -Description "$appname is now configured in 
$(Get-Date -Format 'dd-MMM-yyyy, HH:mm:ss')"

$roleset=@{
    ApplicationId = $appid
    RoleDefinitionName = $RoleDefinitionName
    Scope = $productionResourceGroup.ResourceId
    Description = "$RoleDefinitionName role is now configured in $(Get-Date -Format 'dd-MMM-yyyy, HH:mm:ss')"
}

New-AzRoleAssignment @roleset

az ad sp create-for-rbac --name $productionResourceGroup.ResourceGroupName `
                            --role $RoleDefinitionName `
                            --scopes $productionResourceGroup.ResourceId `
                            --sdk-auth