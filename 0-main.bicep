// Sample deployment command :
// az deployment group create -n Deploy -g azure-avs-microhack-rg --template-file 1-main.bicep 
// with "--parameter .\param\main.param.json" if parameters are used

// Location to deploy the below resources
param location string = 'canadacentral'

// If you want to deploy the Express Route (ER) gateway : true. Otherwise : false
param deployEr bool = true

// Hacker number to pick the correct IP ranges
@allowed([
  1
  2
  3
  4
  5
  6
  7
  8
  9
  10
  11
  12
])
param hackerId int

// Change the scope to be able to create the resource group before resources
// then we specify scope at resourceGroup level for all others resources
targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'azure-avs-microhack-rg'
  location: location
}


// Create base virtual network to host the Jumpbox and the Express Route gateway
module adminVnet './_modules/vnet.bicep' = {
  name: 'adminVnet'
  scope: rg
  params: {
    location: location
    name: 'adminVnet'
    hackerId: hackerId
  }
}

// Create the Express Route gateway in the base virtual network
module ergw './_modules/ergw.bicep' = if(deployEr) {
  name: 'er-gw'
  scope: rg
  params: {
    gwSubnetId: adminVnet.outputs.subnets[0].id
    location: location
    name: 'er-gw'
  }
}

// Create the jumpbox VM

module jumpboxVm './_modules/vm.bicep' = {
  name: 'jumpbox'
  scope: rg
  params: {
    location: location
    subnetId: adminVnet.outputs.subnets[1].id
    vmName: 'jumpbox'
  }
}

// Azure Bastion to admin the jumpbox if required

module bastionHost '_modules/bastion.bicep' = {
  name: 'bastion'
  scope: rg
  params: {
    location: location
    name: 'bastion'
    subnetId: adminVnet.outputs.subnets[2].id
  } 
}
