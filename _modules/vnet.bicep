param location string
param name string
param userId int
param proctorId int

var userIdIndex = userId - 1

//Users IP ranges definition
var usersIpRanges = [
{
  user : 1
  addressSpace : '10.228.16.0/26'
  subnets : [
    '10.228.16.0/28'
    '10.228.16.16/28'
    '10.228.16.32/27'
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
  addressSpace : '10.228.16.64/26'
  subnets : [
    '10.228.16.64/28'
    '10.228.16.80/28'
    '10.228.16.96/27'
    'NA'
  ]
  asn : 65002
  remoteAsn: 65013
  ownBgpIp : '10.228.16.78'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-2-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 3
  addressSpace : '10.228.16.128/26'
  subnets : [
    '10.228.16.128/28'
    '10.228.16.144/28'
    '10.228.16.160/27'
    'NA'
  ]
  asn : 65003
  remoteAsn: 65013
  ownBgpIp : '10.228.16.142'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-3-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 4
  addressSpace : '10.228.16.192/26'
  subnets : [
    '10.228.16.192/27'
    '10.228.16.224/28'
    '10.228.16.256/27'
    'NA'
  ]
  asn : 65004
  remoteAsn: 65013
  ownBgpIp : '10.228.16.206'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-4-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 5
  addressSpace : '10.228.20.0/26'
  subnets : [
    '10.228.20.0/28'
    '10.228.20.16/28'
    '10.228.20.32/27'
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
  addressSpace : '10.228.20.64/26'
  subnets : [
    '10.228.20.64/28'
    '10.228.20.80/28'
    '10.228.20.96/27'
    'NA'
  ]
  asn : 65006
  remoteAsn: 65013
  ownBgpIp : '10.228.20.78'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-6-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 7
  addressSpace : '10.228.20.128/26'
  subnets : [
    '10.228.20.128/28'
    '10.228.20.144/28'
    '10.228.20.160/27'
    'NA'
  ]
  asn : 65007
  remoteAsn: 65013
  ownBgpIp : '10.228.20.142'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-7-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 8
  addressSpace : '10.228.20.192/26'
  subnets : [
    '10.228.20.192/28'
    '10.228.20.208/28'
    '10.228.20.224/27'
    'NA'
  ]
  asn : 65008
  remoteAsn: 65013
  ownBgpIp : '10.228.20.206'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-8-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 9
  addressSpace : '10.228.24.0/26'
  subnets : [
    '10.228.24.0/28'
    '10.228.24.16/28'
    '10.228.24.32/27'
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
  addressSpace : '10.228.24.64/26'
  subnets : [
    '10.228.24.64/28'
    '10.228.24.80/28'
    '10.228.24.96/27'
    'NA'
  ]
  asn : 65010
  remoteAsn: 65013
  ownBgpIp : '10.228.24.78'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-10-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 11
  addressSpace : '10.228.24.128/26'
  subnets : [
    '10.228.24.128/28'
    '10.228.24.144/28'
    '10.228.24.160/27'
    'NA'
  ]
  asn : 65011
  remoteAsn: 65013
  ownBgpIp : '10.228.24.142'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-11-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 12
  addressSpace : '10.228.24.192/26'
  subnets : [
    '10.228.24.192/28'
    '10.228.24.208/28'
    '10.228.24.224/27'
    'NA'
  ]
  asn : 65012
  remoteAsn: 65013
  ownBgpIp : '10.228.24.206'
  remoteBgpIp: '10.228.17.14'
  vpnGatewayDnsPrefix : 'user-12-vpn-gw-pip'
  remoteVpnGatewayDnsPrefix : 'proctor-${proctorId}-vpn'
}
{
  user : 13
  addressSpace : '10.228.17.0/24'
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
