param location string
param gwSubnetId string
param name string
param variables object
param userId int

var userIdIndex = userId - 1

resource vpnGateway 'Microsoft.Network/virtualNetworkGateways@2020-11-01' = {
  name: name
  location: location
  properties: {
    gatewayType: 'Vpn'
    sku: {
        name: 'VpnGw1AZ'
        tier: 'VpnGw1AZ'
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
    bgpSettings: {
      asn: variables.usersIpRanges[userIdIndex].asn
    }
    enableBgp: true
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    activeActive: userId == 14 ? true : false
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: '${name}-pip-${variables.sessionId}'
  location: location
  sku: {
    name:'Standard'
    tier:'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
   publicIPAllocationMethod: 'Static'
   dnsSettings: {
     domainNameLabel: '${variables.usersIpRanges[userIdIndex].vpnGatewayDnsPrefix}-${variables.sessionId}'
   }
  }
}

output vpnGwId string = vpnGateway.id
output vpnGwPipFqdn string = publicIp.properties.dnsSettings.fqdn
