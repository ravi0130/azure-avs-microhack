// Sample deployment command :
// az deployment group create -n Deploy -g azure-avs-microhack-rg --template-file 1-main.bicep 
// with "--parameter .\param\main.param.json" if parameters are used

// Location to deploy the below resources
param location string = 'canadacentral'

// If you want to deploy the Express Route (ER) gateway : true. Otherwise : false
param deployGateway bool = true

// Change the scope to be able to create the resource group before resources
// then we specify scope at resourceGroup level for all others resources
targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'azure-avs-microhack-proctor0-rg'
  location: location
}


// Create base virtual network to host the Jumpbox and the Express Route gateway
module adminVnet '../_modules/vnet.bicep' = {
  name: 'adminVnet'
  scope: rg
  params: {
    location: location
    name: 'adminVnet'
    userId: 13
  }
}

// Create the VPN gateway in the base virtual network
module vpnGw '../_modules/vpngw.bicep' = if(deployGateway) {
  name: 'vpn-gw'
  scope: rg
  params: {
    gwSubnetId: adminVnet.outputs.subnets[0].id
    location: location
    name: 'vpn-gw'
    userId: 13
    usersIpRanges: adminVnet.outputs.usersIpRanges
  }
}

// // LNG to Hub
// module lngToUsers '../_modules/lng.bicep' = [ for user in range(1,12): {
//   scope: rg
//   name: 'lngToUser-${user}'
//   params: {
//     location: location
//     name: 'lngToUser-${user}'
//     userId: user
//     usersIpRanges: adminVnet.outputs.usersIpRanges
//   }
// }]

// LNG to Hub
module lngToUsers '../_modules/lng4proctor.bicep' = [ for user in range(1,12): {
  scope: rg
  name: 'lngToUser-${user}'
  params: {
    location: location
    name: 'lngToUser-${user}'
    userId: user
    usersIpRanges: adminVnet.outputs.usersIpRanges
  }
}]

// connection to users
module vpnToUsersConnection '../_modules/vpnConnection.bicep' = [ for user in range(1,12): {
  scope: rg
  name: 'connectionToUser-${user}'
  params: {
    location: location
    name: 'connectionToUser-${user}'
    remoteLngId: lngToUsers[user -1].outputs.lngId
    vpnGwId: vpnGw.outputs.vpnGwId
    vpnPreSharedKey: 'MicrosoftMicroHack@1234$'
  } 
}]

// Create the Express Route gateway in the base virtual network
module erGw '../_modules/ergw.bicep' = if(deployGateway) {
  name: 'er-gw'
  scope: rg
  params: {
    gwSubnetId: adminVnet.outputs.subnets[0].id
    location: location
    name: 'er-gw'
  }
}

// Create the route server
module routeServer '../_modules/routeserver.bicep' = {
  scope: rg
  name: 'routeServer'
  params: {
    location: location
    name: 'routeServer'
    subnetId: adminVnet.outputs.subnets[3].id
  }
  
}

// Create the jumpbox VM

module jumpboxVm '../_modules/vm.bicep' = {
  name: 'jumpbox'
  scope: rg
  params: {
    location: location
    subnetId: adminVnet.outputs.subnets[1].id
    vmName: 'jumpbox'
  }
}

// Azure Bastion to admin the jumpbox if required

module bastionHost '../_modules/bastion.bicep' = {
  name: 'bastion'
  scope: rg
  params: {
    location: location
    name: 'bastion'
    subnetId: adminVnet.outputs.subnets[2].id
  } 
}
