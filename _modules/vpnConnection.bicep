param location string
param name string
param vpnGwId string
param remoteLngId string

@secure()
param vpnPreSharedKey string

resource vpnConnection 'Microsoft.Network/connections@2020-11-01' = {
  name: name
  location: location
  properties: {
    connectionType: 'IPsec'
    connectionProtocol: 'IKEv2'
    connectionMode: 'Default'
    enableBgp: true
    sharedKey: vpnPreSharedKey
    virtualNetworkGateway1: {
      id: vpnGwId
      properties:{
        
      }
    }
    localNetworkGateway2: {
      id: remoteLngId
      properties: {
      }
    }
  }
}
