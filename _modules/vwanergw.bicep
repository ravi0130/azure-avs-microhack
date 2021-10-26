param location string
param gwName string
param vHubId string
param vHubName string
param avsCircuitIds array
param connectCircuits bool

resource vHubErGw 'Microsoft.Network/expressRouteGateways@2021-03-01' = {
  name: gwName
  location: location
  properties: {
    virtualHub: {
      id: vHubId
    }
    autoScaleConfiguration: {
      bounds: {
        min: 1
      }
    }
  }
}

@batchSize(1)
resource erCircuit 'Microsoft.Network/expressRouteGateways/expressRouteConnections@2021-03-01' = [ for (avsCircuit, index) in avsCircuitIds : if(connectCircuits) {
  name: '${gwName}/Connection-${index}'
  properties: {
    authorizationKey: avsCircuit.authKey
    expressRouteCircuitPeering: {
      id: avsCircuit.erCircuitId
    }
    routingConfiguration: {
      associatedRouteTable: {
        id: resourceId('Microsoft.Network/virtualHubs/hubRouteTables', vHubName, 'defaultRouteTable')
      }
      propagatedRouteTables: {
        ids: [
          {
            id: resourceId('Microsoft.Network/virtualHubs/hubRouteTables', vHubName, 'defaultRouteTable')
          }
        ]
      }
    }
  }
}]

output erGwId string = vHubErGw.id
