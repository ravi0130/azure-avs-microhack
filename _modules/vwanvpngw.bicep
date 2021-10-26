param location string
param asn int
param gwName string
param vHubId string

resource vpnGw 'Microsoft.Network/vpnGateways@2021-02-01' = {
  name: gwName
  location: location
  properties: {
    bgpSettings: {
      asn: asn
    }
    virtualHub: {
      id: vHubId
    }
  } 
}
