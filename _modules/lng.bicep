param location string
param name string
param usersIpRanges array
param userId int
@allowed([
  1
  2
])
param tunnelId int

var userIdIndex = userId - 1

// We use a custom domain name as Public IP attached to VPN GWs cannot have a DNS prefix that works ...
var dnsDomain = '${location}.cloudapp.azure.com'

resource lng 'Microsoft.Network/localNetworkGateways@2021-02-01' = {
  name: name
  location: location
  properties: {
    bgpSettings: {
      asn: usersIpRanges[userIdIndex].remoteAsn
      bgpPeeringAddress: tunnelId == 1 ? usersIpRanges[userIdIndex].remoteBgpIp : usersIpRanges[userIdIndex].remoteBgpIp2
    }
    fqdn: tunnelId == 1 ? '${usersIpRanges[userIdIndex].remoteVpnGatewayDnsPrefix}.${dnsDomain}' : '${usersIpRanges[userIdIndex].remoteVpnGatewayDnsPrefix2}.${dnsDomain}'
    localNetworkAddressSpace: {
      addressPrefixes: [
        tunnelId == 1 ? '${usersIpRanges[userIdIndex].remoteBgpIp}/32' : '${usersIpRanges[userIdIndex].remoteBgpIp2}/32'
      ]
    }
    }
  }

output lngId string = lng.id
