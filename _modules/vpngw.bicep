param location string
param gwSubnetId string
param name string
param usersIpRanges array
param userId int
param diagsStorageAccountId string = 'NA'
param logAnalyticsWsId string = 'NA'

var userIdIndex = userId - 1

var activeStandby = [
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

var activeActive = [
  {
    name: 'ipconfig2'
    properties: {
      subnet: {
        id: gwSubnetId
      }
      publicIPAddress: {
        id: publicIp2.id
      }
    }
  }
]

resource vpnGateway 'Microsoft.Network/virtualNetworkGateways@2020-11-01' = {
  name: name
  location: location
  properties: {
    gatewayType: 'Vpn'
    sku: {
        name: 'VpnGw1AZ'
        tier: 'VpnGw1AZ'
    }
    ipConfigurations: userId == 14 ? union(activeStandby, activeActive) : activeStandby
    bgpSettings: {
      asn: usersIpRanges[userIdIndex].asn
    }
    enableBgp: true
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    activeActive: userId == 14 ? true : false
  }
}

resource vpnDiag 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (userId == 14) {
  name: 'diag'
  scope: vpnGateway
  properties: {
    logs: [
      {
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true 
        }
        category: 'RouteDiagnosticLog'
      }
      {
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true 
        }
        category: 'IKEDiagnosticLog'
      }
      {
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true 
        }
        category: 'TunnelDiagnosticLog'
      }
      {
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true 
        }
        category: 'GatewayDiagnosticLog'
      }
    ]
    storageAccountId: diagsStorageAccountId
    workspaceId: logAnalyticsWsId
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: '${name}-pip'
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
     domainNameLabel: '${usersIpRanges[userIdIndex].vpnGatewayDnsPrefix}'
   }
  }
}

resource publicIp2 'Microsoft.Network/publicIPAddresses@2020-08-01' = if(userId == 14) {
  name: '${name}-pip-2'
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
     domainNameLabel: '${usersIpRanges[userIdIndex].vpnGatewayDnsPrefix}-2'
   }
  }
}

output vpnGwId string = vpnGateway.id
output vpnGwPipFqdn string = publicIp.properties.dnsSettings.fqdn
