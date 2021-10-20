param location string
param name string
param routes array

resource rt 'Microsoft.Network/routeTables@2021-03-01' = {
  name: name
  location: location
  properties: {
    routes: [ for route in routes: {
      name: route.name
      properties: {
        nextHopType: route.nextHopType
        addressPrefix: route.addressPrefix
      }
    }]
  }
}
