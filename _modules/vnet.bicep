param location string
param name string

resource adminVnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: name
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

output subnets array = adminVnet.properties.subnets
