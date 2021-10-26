param location string
param name string

resource vWan 'Microsoft.Network/virtualWans@2021-03-01' = {
  name: name
  location: location
  properties: {
  }
}

output vWanId string = vWan.id
