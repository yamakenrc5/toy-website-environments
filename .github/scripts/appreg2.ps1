$githubOrganizationName = 'yamakenrc5'
$githubRepositoryName = 'toy-website-environments'
$appname = "$($githubRepositoryName)-production"
$prodappname="$($githubRepositoryName)-production"
$productionApplicationRegistration = New-AzADApplication `
-DisplayName $appname

$productionApplicationRegistration = New-AzADApplication `
-DisplayName "$($appname)-production"

$prodset = @{
    Name = $prodappname
    ApplicationObjectId = $productionApplicationRegistration.Id
    Issuer = 'https://token.actions.githubusercontent.com'
    Audience = 'api://AzureADTokenExchange'
    Subject =  "repo:$($githubOrganizationName)/$($githubRepositoryName)`
    :environment:Production"
}

$prodbrset = @{
    Name = "$($prodappname)-branch"
    ApplicationObjectId = $productionApplicationRegistration.Id
    Issuer = 'https://token.actions.githubusercontent.com'
    Audience = 'api://AzureADTokenExchange'
    Subject =  "repo:$($githubOrganizationName)/$($githubRepositoryName)`
    :ref:refs/heads/main"
}
New-AzADAppFederatedCredential @prodset
New-AzADAppFederatedCredential @prodbrset
.\prodrg.ps1
.\createsecret.ps1