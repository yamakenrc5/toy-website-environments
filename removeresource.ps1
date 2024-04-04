#$target = @("ToyWebsiteTest","ToyWebsiteProduction")
$target=(Get-AzResourceGroup) | Where-Object { $_.ResourceGroupName -like "*ToyWebsite*" } | Select-Object -ExpandProperty ResourceGroupName

ForEach ($rg in $target) {Remove-AzResourceGroup -Name $rg -Force} #-whatif}

# az group delete -n $rg --no-wait