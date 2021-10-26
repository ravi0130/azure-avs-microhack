param location string
param name string
param userId int
param usersIpRanges array
param dnsServer string = '10.228.17.37'

var userIdIndex = userId - 1

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

resource adminVnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        usersIpRanges[userIdIndex].addressSpace
      ]
    }
    subnets: usersSubnets
    dhcpOptions: {
      dnsServers: [
        dnsServer
      ]
    }
  }
}

output subnets array = adminVnet.properties.subnets
output vnetId string = adminVnet.id
