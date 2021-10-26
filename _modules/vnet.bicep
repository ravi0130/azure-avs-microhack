param location string
param name string
param userId int
param usersIpRanges array

@allowed([
  'default'
  'proctor'
])
param dnsServer string = 'proctor'

var userIdIndex = userId - 1

var dnsServerIp = {
  dnsServers: [
    usersIpRanges[userIdIndex].dnsServer
  ]
}

var usersSubnets = [
  {
    name: 'GatewaySubnet'
    properties: {
      addressPrefix: usersIpRanges[userIdIndex].subnets[0]
    }
  }
  {
    name: 'jumpbox'
    properties: {
      addressPrefix: usersIpRanges[userIdIndex].subnets[1]
    }
  }
  {
    name: 'AzureBastionSubnet'
    properties: {
      addressPrefix: usersIpRanges[userIdIndex].subnets[2]
    }
  }
]

var routeServerSubnet = [
  {
    name: 'RouteServerSubnet'
    properties: {
      addressPrefix: usersIpRanges[userIdIndex].subnets[3]
    }
  }
]

resource adminVnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        usersIpRanges[userIdIndex].addressSpace
      ]
    }
    subnets: userId == 14 ? union(usersSubnets, routeServerSubnet) : usersSubnets
    dhcpOptions: dnsServer == 'default' ? json('null') : dnsServerIp
  }
}

output subnets array = adminVnet.properties.subnets
