param location string
param gwSubnetId string
param name string
param usersIpRanges array
param userId int

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
    ipConfigurations: userId == 13 ? union(activeStandby, activeActive) : activeStandby
    bgpSettings: {
      asn: usersIpRanges[userIdIndex].asn
    }
    enableBgp: true
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    activeActive: userId == 13 ? true : false
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: '${name}-pip'
  location: location
  sku: {
    name:'Basic'
    tier:'Regional'
  }
  properties: {
   publicIPAllocationMethod: 'Dynamic'
   dnsSettings: {
     domainNameLabel: '${usersIpRanges[userIdIndex].vpnGatewayDnsPrefix}'
   }
  }
}

resource publicIp2 'Microsoft.Network/publicIPAddresses@2020-08-01' = if(userId == 13) {
  name: '${name}-pip-2'
  location: location
  sku: {
    name:'Basic'
    tier:'Regional'
  }
  properties: {
   publicIPAllocationMethod: 'Dynamic'
   dnsSettings: {
     domainNameLabel: '${usersIpRanges[userIdIndex].vpnGatewayDnsPrefix}-2'
   }
  }
}

output vpnGwId string = vpnGateway.id
output vpnGwPipFqdn string = publicIp.properties.dnsSettings.fqdn
