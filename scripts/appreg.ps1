$githubOrganizationName = 'yamakenrc5'
$githubRepositoryName = 'toy-website-environments'
$appname = "$($githubRepositoryName)-test"
$prodappname="$($githubRepositoryName)-production"

# Get all registered applications with the specified display name
$applications = Get-AzADApplication -Filter "displayName eq '$appname'"

# Remove each previous application instance before proceeding 
foreach ($app in $applications) {
    if ($app.AppId) {
        Remove-AzADApplication -ApplicationId $app.AppId
    } else {Write-Error: "AppId for the $app is not found"}
}

if (-not $testApplicationRegistration) {
    $testApplicationRegistration = New-AzADApplication `
    -DisplayName $appname
    }

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
# .\createsecret.ps1