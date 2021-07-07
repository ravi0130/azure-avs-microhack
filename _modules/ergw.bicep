param location string
param gwSubnetId string
param name string

resource erGateway 'Microsoft.Network/virtualNetworkGateways@2020-11-01' = {
  name: name
  location: location
  properties: {
    gatewayType: 'ExpressRoute'
    sku: {
      name: 'Standard'
      tier: 'Standard'
    }
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: gwSubnetId
          }
          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: 'ergw-pip'
  location: location
  sku: {
    name:'Basic'
    tier:'Regional'
  }
  properties: {
   publicIPAllocationMethod: 'Dynamic'
  }
}

output erGwId string = erGateway.id
