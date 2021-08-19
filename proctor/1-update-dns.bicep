// Sample deployment command :
// az deployment group create -n Deploy -g azure-avs-microhack-rg --template-file 1-main.bicep 
// with "--parameter .\param\main.param.json" if parameters are used

// Location to deploy the below resources
// param location string = 'canadacentral'
param location string = 'canadacentral'

// Proctor number. Always use 1 instead you have to deploy a test proctor instance as all proctor instances uses sames IPs
@allowed([
  1
  2
  3
  4
])
param proctorId int = 2

// Change the scope to be able to create the resource group before resources
// then we specify scope at resourceGroup level for all others resources
targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'azure-avs-microhack-proctor-${proctorId}-rg'
  location: location
}


// Update base virtual network with correct DNS
module adminVnet '../_modules/vnet.bicep' = {
  name: 'adminVnet'
  scope: rg
  params: {
    location: location
    name: 'adminVnet'
    userId: 13
    proctorId: proctorId
    dnsServer: 'proctor'
  }
}
