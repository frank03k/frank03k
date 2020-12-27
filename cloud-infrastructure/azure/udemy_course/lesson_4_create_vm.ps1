Login-AzureRmAccount

Get-AzureRmSubscription

cd\
cls


New-AzureRmVm `
    -ResourceGroupName "test-vm-rg" `
    -Name "myVM" `
    -Location "westeurope" `
    -VirtualNetworkName "VMs-Testumgebung" `
    -SubnetName "test-network-vm" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389