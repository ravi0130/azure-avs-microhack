param location string
param name string
param userId int
param variables object
@allowed([
  1
  2
])
param tunnelId int

var userIdIndex = userId - 1


resource lng 'Microsoft.Network/localNetworkGateways@2021-02-01' = {
  name: name
  location: location
  properties: {
    bgpSettings: {
      asn: variables.usersIpRanges[userIdIndex].remoteAsn
      bgpPeeringAddress: tunnelId == 1 ? variables.usersIpRanges[userIdIndex].remoteBgpIp : variables.usersIpRanges[userIdIndex].remoteBgpIp2
    }
    gatewayIpAddress: tunnelId == 1 ? '${variables.usersIpRanges[userIdIndex].remoteVpnGatewayPublicIp}' : '${variables.usersIpRanges[userIdIndex].remoteVpnGatewayPublicIp2}'
    localNetworkAddressSpace: {
      addressPrefixes: [
        tunnelId == 1 ? '${variables.usersIpRanges[userIdIndex].remoteBgpIp}/32' : '${variables.usersIpRanges[userIdIndex].remoteBgpIp2}/32'
      ]
    }
    }
  }

output lngId string = lng.id
