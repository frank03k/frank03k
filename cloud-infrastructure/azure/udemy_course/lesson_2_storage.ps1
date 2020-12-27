Login-AzureRmAccount

Get-AzureRmSubscription

cd\
cls

$location = "westeurope"
$group = "test-vm-rg"

$account = New-AzureRmStorageAccount -ResourceGroupName $group -Name tw012018 -Location $location -SkuName Standard_LRS

Get-AzureRMStorageAccount | Select StorageAccountName, Location

#Azure CLI

az login

$group = "test-vm-rg"
$location = "westeurope"
$account = "tw012018"

az storage account create --resource-group-name $group --location $location --sku Standard_LRS --name $account

az storage account show --resource-group $group --name $account