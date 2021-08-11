param location string
param name string
param usersIpRanges array
param userId int

var userIdIndex = userId - 1

resource lng 'Microsoft.Network/localNetworkGateways@2021-02-01' = {
  name: name
  location: location
  properties: {
    bgpSettings: {
      asn: usersIpRanges[userIdIndex].remoteAsn
      bgpPeeringAddress: usersIpRanges[userIdIndex].remoteBgpIp
    }
    fqdn: '${usersIpRanges[userIdIndex].remoteVpnGatewayDnsPrefix}.${location}.cloudapp.azure.com'
    localNetworkAddressSpace: {
      addressPrefixes: [
        '${usersIpRanges[userIdIndex].remoteBgpIp}/32'
      ]
    }
    }
  }

output lngId string = lng.id
