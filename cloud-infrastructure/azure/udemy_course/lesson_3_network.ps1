Login-AzureRmAccount

Get-AzureRmSubscription

cd\
cls

$location = "westeurope"
$group = "test-vm-rg"

# Erstellen des Subnetz
$vnet = New-AzureRmVirtualNetwork -Name vnet-test-powershell -ResourceGroupName $group -Location $location `
                -AddressPrefix "10.2.0.0/24"

Add-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name BaseSubnet -AddressPrefix "10.2.0.32/27"
Add-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name WebSubnet -AddressPrefix "10.2.0.64/27"
Add-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name DBSubnet -AddressPrefix "10.2.0.96/27"

Set-AzureRmVirtualNetwork -VirtualNetwork $vnet

#Azure CLI

az login --use-device-code

$group = "test-vm-rg"
$location = "westeurope"


az network vnet create --resource-group $group --location $location --name vnet-test-azurecli --address-prefixes "10.1.0.0/24" --subnet-name BaseSubnet --subnet-prefix "10.1.0.0/27"
az network vnet subnet create --resource-group $group --vnet-name vnet-test-azurecli --name WebSubnet --address-prefix "10.1.0.32/27"
az network vnet subnet create --resource-group $group --vnet-name vnet-test-azurecli --name DBSubnet --address-prefix "10.1.0.64/27"