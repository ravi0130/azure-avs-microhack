param location string
param name string
param usersIpRanges array
param userId int

var userIdIndex = userId - 1

// We use a custom domain name as Public IP attached to VPN GWs cannot have a DNS prefix that works ...
var dnsDomain = '${location}.cloudapp.azure.com'

resource lng 'Microsoft.Network/localNetworkGateways@2021-02-01' = {
  name: name
  location: location
  properties: {
    bgpSettings: {
      asn: usersIpRanges[userIdIndex].asn
      bgpPeeringAddress: usersIpRanges[userIdIndex].ownBgpIp
    }
    fqdn: '${usersIpRanges[userIdIndex].vpnGatewayDnsPrefix}.${dnsDomain}'
    
    localNetworkAddressSpace: {
      addressPrefixes: [
        '${usersIpRanges[userIdIndex].ownBgpIp}/32'
      ]
    }
    }
  }

output lngId string = lng.id
