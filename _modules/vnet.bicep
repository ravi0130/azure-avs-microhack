param location string
param name string
param hackerId int

var hackerIdIndex = hackerId - 1

//Hackers IP ranges definition
var hackersIpRanges = [
{
  hacker : 1
  addressSpace : '10.228.16.0/26'
  subnets : [
    '10.228.16.0/28'
    '10.228.16.16/28'
    '10.228.16.32/27'
  ]
}
{
  hacker : 2
  addressSpace : '10.228.16.64/26'
  subnets : [
    '10.228.16.64/28'
    '10.228.16.80/28'
    '10.228.16.96/27'
  ]
}
{
  hacker : 3
  addressSpace : '10.228.16.128/26'
  subnets : [
    '10.228.16.128/28'
    '10.228.16.144/28'
    '10.228.16.160/27'
  ]
}
{
  hacker : 4
  addressSpace : '10.228.16.192/26'
  subnets : [
    '10.228.16.192/28'
    '10.228.16.208/28'
    '10.228.16.224/27'
  ]
}
{
  hacker : 5
  addressSpace : '10.228.20.0/26'
  subnets : [
    '10.228.20.0/28'
    '10.228.20.16/28'
    '10.228.20.32/27'
  ]
}
{
  hacker : 6
  addressSpace : '10.228.20.64/26'
  subnets : [
    '10.228.20.64/28'
    '10.228.20.80/28'
    '10.228.20.96/27'
  ]
}
{
  hacker : 7
  addressSpace : '10.228.20.128/26'
  subnets : [
    '10.228.20.128/28'
    '10.228.20.144/28'
    '10.228.20.160/27'
  ]
}
{
  hacker : 8
  addressSpace : '10.228.20.192/26'
  subnets : [
    '10.228.20.192/28'
    '10.228.20.208/28'
    '10.228.20.224/27'
  ]
}
{
  hacker : 9
  addressSpace : '10.228.24.0/26'
  subnets : [
    '10.228.24.0/28'
    '10.228.24.16/28'
    '10.228.24.32/27'
  ]
}
{
  hacker : 10
  addressSpace : '10.228.24.64/26'
  subnets : [
    '10.228.24.64/28'
    '10.228.24.80/28'
    '10.228.24.96/27'
  ]
}
{
  hacker : 11
  addressSpace : '10.228.24.128/26'
  subnets : [
    '10.228.24.128/28'
    '10.228.24.144/28'
    '10.228.24.160/27'
  ]
}
{
  hacker : 12
  addressSpace : '10.228.24.192/26'
  subnets : [
    '10.228.24.192/28'
    '10.228.24.208/28'
    '10.228.24.224/27'
  ]
}

]
resource adminVnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        hackersIpRanges[hackerIdIndex].addressSpace
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: hackersIpRanges[hackerIdIndex].subnets[0]
        }
      }
      {
        name: 'jumpbox'
        properties: {
          addressPrefix: hackersIpRanges[hackerIdIndex].subnets[1]
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: hackersIpRanges[hackerIdIndex].subnets[2]
        }
      }
    ]
  }
}

output subnets array = adminVnet.properties.subnets
