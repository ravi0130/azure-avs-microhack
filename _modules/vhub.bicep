param location string
param name string
param vwanId string
param addressPrefix string

resource vHub 'Microsoft.Network/virtualHubs@2021-03-01' = {
  name: name
  location: location
  properties: {
    addressPrefix: addressPrefix
    sku: 'Standard'
    virtualWan: {
      id: vwanId
    }
  }
}

output vHubId string = vHub.id
