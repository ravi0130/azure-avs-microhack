param location string = 'canadacentral'

// If you want to deploy the Express Route (ER) gateway : true. Otherwise : false
param deployErGateway bool = false
// Connect circuits to ER GW
param connectCircuits bool = false

// If you want to deploy the VPN gateway : true. Otherwise : false
param deployVpnGateway bool = true

// Parameter to connects the AVS circuits
param avsCircuitIds array = []

// Proctor number. Always use 1 instead you have to deploy a test proctor instance as all proctor instances uses sames IPs
@allowed([
  1
  2
  3
  4
])
param proctorId int = 1

// Change the scope to be able to create the resource group before resources
// then we specify scope at resourceGroup level for all others resources
targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'azure-avs-microhack-proctor-${proctorId}-rg'
  location: location
}

// Create a storage account for diags
module storageAccount '../_modules/storageaccount.bicep' = {
  scope: rg
  name: 'proctor${proctorId}sa'
  params: {
    location: location
    name: 'proctor${proctorId}sa'
  }
}

// Load main variable file
var variables = json(loadTextContent('../vars/vars.json'))

// Create base virtual network to host the Jumpbox and the Express Route gateway
module adminVnet '../_modules/vnet.bicep' = {
  name: 'adminVnet'
  scope: rg
  params: {
    location: location
    name: 'adminVnet'
    userId: 14
    dnsServer: variables.proctorDnsServer
    usersIpRanges: variables.usersIpRanges
  }
}

// Define the vWan object
module vWan '../_modules/vwan.bicep' = {
  scope: rg
  name: 'avs-vwan'
  params: {
    location: location
    name: 'avs-vwan'
  }
}

// Define a single hub for interco with students and AVS
module vHub1 '../_modules/vhub.bicep' = {
  scope: rg
  name: 'h-${location}'
  params: {
    addressPrefix: variables.vWanAddressSpace
    location: location
    name: 'h-${location}'
    vwanId: vWan.outputs.vWanId
  }
}

// Add the ER Gateway
module erGw '../_modules/vwanergw.bicep' = if(deployErGateway) {
  scope: rg
  name: 'erGw-${location}'
  params: {
    avsCircuitIds: avsCircuitIds
    gwName: 'erGw-${location}'
    location: location
    vHubId: vHub1.outputs.vHubId
    vHubName: vHub1.outputs.vHubName
    connectCircuits: connectCircuits
  }
}

// Add the VPN Gateway and sites
module hubVpnGw '../_modules/vwanvpngw.bicep' = if(deployVpnGateway) {
  scope: rg
  name: 'proctorVpnGw-${location}'
  params: {
    asn: 65515
    gwName: 'proctorVpnGw-${location}'
    location: location
    vHubId: vHub1.outputs.vHubId
  } 
}

// Connect server vNet
module adminVnetConnection '../_modules/vwanvnetconnection.bicep' = {
  scope: rg
  name: '${adminVnet.name}_connection'
  params: {
    connectionName: '${adminVnet.name}_connection'
    vHubName: vHub1.outputs.vHubName
    vHubId: vHub1.outputs.vHubId
    vNetId: adminVnet.outputs.vnetId
  }
}

// Add studient sites

@batchSize(1)
module vpnSites '../_modules/vwanvpnsite.bicep' = [ for user in variables.usersIpRanges: if(deployVpnGateway) {
  scope: rg
  name: 'user-${user.asn}'
  params: {
    asn: user.asn
    userId: user.user
    bgpIp: user.ownBgpIp
    location: location
    name: 'user-${user.asn}'
    publicIp: '${user.vpnGatewayDnsPrefix}-${variables.sessionId}.${variables.dnsDomain}'
    vWanId: vWan.outputs.vWanId
    vpnGatewayName: hubVpnGw.name
  }
}]

// Create the jumpbox VM

module jumpboxVm '../_modules/vm.bicep' = {
  name: 'jumpbox'
  scope: rg
  params: {
    location: location
    subnetId: adminVnet.outputs.subnets[1].id
    vmName: 'jumpbox'
    osType: 'desktop'
  }
}

// Create extra jumpbox VM
module extraJumpboxVm '../_modules/vm.bicep' = [for index in range(1, 3):{
  name: 'jumpbox${index}'
  scope: rg
  params: {
    location: location
    subnetId: adminVnet.outputs.subnets[1].id
    vmName: 'jumpbox${index}'
    osType: 'desktop'
  }
}]

// Create the server for DNS

module serverVm '../_modules/vm.bicep' = {
  name: 'server'
  scope: rg
  params: {
    location: location
    subnetId: adminVnet.outputs.subnets[1].id
    vmName: 'server'
    osType: 'server'
    autoShutdownStatus: 'Disabled'
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
