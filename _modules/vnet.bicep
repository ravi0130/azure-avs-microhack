param location string
param name string
param hackerId int

var hackerIdIndex = hackerId - 1

//Hackers IP ranges definition
var hackersIpRanges = [
{
  hacker : 1
  addressSpace : '10.228.16.0/27'
  subnets : [
    '10.228.16.0/28'
    '10.228.16.16/28'
    '10.228.16.32/28'
  ]
}
{
  hacker : 2
  addressSpace : '10.228.16.64/27'
  subnets : [
    '10.228.16.64/28'
    '10.228.16.80/28'
    '10.228.16.96/28'
  ]
}
{
  hacker : 3
  addressSpace : '10.228.16.128/27'
  subnets : [
    '10.228.16.128/28'
    '10.228.16.144/28'
    '10.228.16.160/28'
  ]
}
{
  hacker : 4
  addressSpace : '10.228.16.192/27'
  subnets : [
    '10.228.16.192/28'
    '10.228.16.208/28'
    '10.228.16.224/28'
  ]
}
{
  hacker : 5
  addressSpace : '10.228.20.0/27'
  subnets : [
    '10.228.20.0/28'
    '10.228.20.16/28'
    '10.228.20.32/28'
  ]
}
{
  hacker : 6
  addressSpace : '10.228.20.64/27'
  subnets : [
    '10.228.20.64/28'
    '10.228.20.80/28'
    '10.228.20.96/28'
  ]
}
{
  hacker : 7
  addressSpace : '10.228.20.128/27'
  subnets : [
    '10.228.20.128/28'
    '10.228.20.144/28'
    '10.228.20.160/28'
  ]
}
{
  hacker : 8
  addressSpace : '10.228.20.192/27'
  subnets : [
    '10.228.20.192/28'
    '10.228.20.208/28'
    '10.228.20.224/28'
  ]
}
{
  hacker : 9
  addressSpace : '10.228.24.0/27'
  subnets : [
    '10.228.24.0/28'
    '10.228.24.16/28'
    '10.228.24.32/28'
  ]
}
{
  hacker : 10
  addressSpace : '10.228.24.64/27'
  subnets : [
    '10.228.24.64/28'
    '10.228.24.80/28'
    '10.228.24.96/28'
  ]
}
{
  hacker : 11
  addressSpace : '10.228.24.128/27'
  subnets : [
    '10.228.24.128/28'
    '10.228.24.144/28'
    '10.228.24.160/28'
  ]
}
{
  hacker : 12
  addressSpace : '10.228.24.192/27'
  subnets : [
    '10.228.24.192/28'
    '10.228.24.208/28'
    '10.228.24.224/28'
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
