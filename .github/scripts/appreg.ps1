$githubOrganizationName = 'yamakenrc5'
$githubRepositoryName = 'toy-website-environments'
$appname = "$($githubRepositoryName)-test"
$prodappname="$($githubRepositoryName)-production"
$testApplicationRegistration = New-AzADApplication `
-DisplayName $appname

$fedset = @{
    Name = $appname
    ApplicationObjectId = $testApplicationRegistration.Id
    Issuer = 'https://token.actions.githubusercontent.com'
    Audience = 'api://AzureADTokenExchange'
    Subject =  "repo:$($githubOrganizationName)/$($githubRepositoryName)`
    :ref:refs/heads/main"
}

$branchset = @{
    Name = "$($appname)-branch"
    ApplicationObjectId = $testApplicationRegistration.Id
    Issuer = 'https://token.actions.githubusercontent.com'
    Audience = 'api://AzureADTokenExchange'
    Subject =  "repo:$($githubOrganizationName)/$($githubRepositoryName)`
    :environment:Test"
}


New-AzADAppFederatedCredential @fedset
New-AzADAppFederatedCredential @branchset
.\testrg.ps1
.\createsecret.ps1