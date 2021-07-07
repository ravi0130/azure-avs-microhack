// Sample deployment command :
// az deployment group create -n Deploy -g azure-avs-microhack-rg --template-file 1-main.bicep 
// with "--parameter .\param\main.param.json" if parameters are used

// Location to deploy the below resources
param location string = 'westeurope'

// If you want to deploy the Express Route (ER) gateway : true. Otherwise : false
param deployEr bool = false


// Create base virtual network to host the Jumpbox and the Express Route gateway
resource adminVnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'adminVnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '172.23.0.0/24'
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '172.23.0.0/27'
        }
      }
      {
        name: 'jumpbox'
        properties: {
          addressPrefix: '172.23.0.32/27'
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '172.23.0.64/27'
        }
      }
    ]
  }
}

// Create the Express Route gateway in the base virtual network
module ergw './_modules/ergw.bicep' = if(deployEr) {
  name: 'er-gw'
  params: {
    gwSubnetId: adminVnet.properties.subnets[0].id
    location: location
    name: 'er-gw'
  }
}

// Create the jumpbox VM

module jumpboxVm './_modules/vm.bicep' = {
  name: 'jumpbox'
  params: {
    location: location
    subnetId: adminVnet.properties.subnets[1].id
    vmName: 'jumpbox'
    createPublicIpNsg: true
  }
}

// Azure Bastion to admin the jumpbox if required

module bastionHost '_modules/bastion.bicep' = {
  name: 'bastion'
  params: {
    location: location
    name: 'bastion'
    subnetId: adminVnet.properties.subnets[2].id
  } 
}
