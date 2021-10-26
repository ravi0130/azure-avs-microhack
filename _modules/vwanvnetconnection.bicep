param vHubName string
param vHubId string
param vNetId string
param connectionName string

resource vnetConnection 'Microsoft.Network/virtualHubs/hubVirtualNetworkConnections@2021-03-01' = {
  name: '${vHubName}/${connectionName}'
  properties: {
    remoteVirtualNetwork: {
      id: vNetId
    }
    routingConfiguration: {
      associatedRouteTable: {
        id: '${vHubId}/hubRouteTables/defaultRouteTable'
      }
      propagatedRouteTables: {
        ids: [
          {
            id: '${vHubId}/hubRouteTables/defaultRouteTable'
          }
        ]
      }
    }
    allowHubToRemoteVnetTransit: true
    allowRemoteVnetToUseHubVnetGateways: true
    enableInternetSecurity: true
  }
}
