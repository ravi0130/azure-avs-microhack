param location string
param name string
param subnetId string

resource routeServer 'Microsoft.Network/virtualHubs@2021-02-01' = {
  name: name
  location: location
  properties: {
    sku: 'Standard'
    allowBranchToBranchTraffic: true
  }
}

resource routeServerIpConfig 'Microsoft.Network/virtualHubs/ipConfigurations@2020-11-01' = {
  name: name
  parent: routeServer
  properties: {
    subnet: {
      id: subnetId
    }
  }
}
