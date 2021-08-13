param location string
param name string
param userId int
param proctorId int

var userIdIndex = userId - 1

//Users IP ranges definition
var usersIpRanges = [
{
  user : 1
  addressSpace : '10.228.16.0/25'
  subnets : [
    '10.228.16.0/27'
    '10.228.16.32/27'
    '10.228.16.64/27'
    'NA'
  ]
  asn : 65001
  remoteAsn: 65013
  ownBgpIp : '10.228.16.14'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-1-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 2
  addressSpace : '10.228.16.128/25'
  subnets : [
    '10.228.16.128/27'
    '10.228.16.160/27'
    '10.228.16.192/27'
    'NA'
  ]
  asn : 65002
  remoteAsn: 65013
  ownBgpIp : '10.228.16.142'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-2-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 3
  addressSpace : '10.228.17.128/25'
  subnets : [
    '10.228.17.128/27'
    '10.228.17.160/27'
    '10.228.17.192/27'
    'NA'
  ]
  asn : 65003
  remoteAsn: 65013
  ownBgpIp : '10.228.17.142'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-3-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 4
  addressSpace : '10.228.18.0/25'
  subnets : [
    '10.228.18.0/27'
    '10.228.18.32/27'
    '10.228.18.64/27'
    'NA'
  ]
  asn : 65004
  remoteAsn: 65013
  ownBgpIp : '10.228.18.14'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-4-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 5
  addressSpace : '10.228.20.0/25'
  subnets : [
    '10.228.20.0/27'
    '10.228.20.32/27'
    '10.228.20.64/27'
    'NA'
  ]
  asn : 65005
  remoteAsn: 65013
  ownBgpIp : '10.228.20.14'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-5-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 6
  addressSpace : '10.228.20.128/25'
  subnets : [
    '10.228.20.128/27'
    '10.228.20.160/27'
    '10.228.20.192/27'
    'NA'
  ]
  asn : 65006
  remoteAsn: 65013
  ownBgpIp : '10.228.20.142'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-6-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 7
  addressSpace : '10.228.21.0/25'
  subnets : [
    '10.228.21.0/27'
    '10.228.21.32/27'
    '10.228.21.64/27'
    'NA'
  ]
  asn : 65007
  remoteAsn: 65013
  ownBgpIp : '10.228.21.14'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-7-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 8
  addressSpace : '10.228.21.128/25'
  subnets : [
    '10.228.21.128/27'
    '10.228.21.160/27'
    '10.228.21.192/27'
    'NA'
  ]
  asn : 65008
  remoteAsn: 65013
  ownBgpIp : '10.228.21.142'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-8-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 9
  addressSpace : '10.228.24.0/25'
  subnets : [
    '10.228.24.0/27'
    '10.228.24.32/27'
    '10.228.24.64/27'
    'NA'
  ]
  asn : 65009
  remoteAsn: 65013
  ownBgpIp : '10.228.24.14'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-9-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 10
  addressSpace : '10.228.24.128/25'
  subnets : [
    '10.228.24.128/27'
    '10.228.24.160/27'
    '10.228.24.192/27'
    'NA'
  ]
  asn : 65010
  remoteAsn: 65013
  ownBgpIp : '10.228.24.142'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-10-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 11
  addressSpace : '10.228.25.0/25'
  subnets : [
    '10.228.25.0/27'
    '10.228.25.32/27'
    '10.228.25.64/27'
    'NA'
  ]
  asn : 65011
  remoteAsn: 65013
  ownBgpIp : '10.228.25.14'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-11-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 12
  addressSpace : '10.228.25.128/25'
  subnets : [
    '10.228.25.128/27'
    '10.228.25.160/27'
    '10.228.25.192/27'
    'NA'
  ]
  asn : 65012
  remoteAsn: 65013
  ownBgpIp : '10.228.25.142'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-12-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 13
  addressSpace : '10.228.17.0/25'
  subnets : [
    '10.228.17.0/27'
    '10.228.17.32/27'
    '10.228.17.64/27'
    '10.228.17.96/27'
  ]
  asn : 65013
  ownBgpIp : '10.228.17.14'
  vpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn-gw-pip'
}
]

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
    subnets: userId == 13 ? union(usersSubnets, routeServerSubnet) : usersSubnets
  }
}

output subnets array = adminVnet.properties.subnets
output usersIpRanges array = usersIpRanges
