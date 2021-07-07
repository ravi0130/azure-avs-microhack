param nicName string
param location string
param subnetId string
param enableForwarding bool = false
param createPublicIpNsg bool = false
param vmName string


resource nicPip 'Microsoft.Network/networkInterfaces@2020-08-01' = if(createPublicIpNsg) {
  name: '${nicName}-public'
  location: location
  properties: {
    enableIPForwarding: enableForwarding
    ipConfigurations: [
      {
        name: 'ipconfig0'
        properties: {
          primary:true
          privateIPAllocationMethod:'Dynamic'
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource nicNoPip 'Microsoft.Network/networkInterfaces@2020-08-01' = if(!createPublicIpNsg) {
  name: nicName
  location: location
  properties: {
    enableIPForwarding: enableForwarding
    ipConfigurations: [
      {
        name: 'ipconfig0'
        properties: {
          primary:true
          privateIPAllocationMethod:'Dynamic'
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-08-01' = if(createPublicIpNsg) {
  name: '${nicName}-pip'
  location: location
  sku: {
    name:'Standard'
    tier:'Regional'
  }
  properties: {
   publicIPAllocationMethod: 'Static'
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-11-01' = if(createPublicIpNsg) {
  name: '${vmName}-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'allow-ssh'
        properties: {
          access:'Allow'
          description:'Allow SSH from outside'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
          direction:'Inbound'
          protocol:'Tcp'
          priority: 200
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
        }
      }
      {
        name: 'allow-rdp'
        properties: {
          access:'Allow'
          description:'Allow RDP from outside'
          destinationAddressPrefix: '*'
          destinationPortRange: '3389'
          direction:'Inbound'
          protocol:'Tcp'
          priority: 210
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
        }
      }
    ]
  }
}

output nicId string = createPublicIpNsg ? '${nicPip.id}' : '${nicNoPip.id}'
output nicPrivateIp string = createPublicIpNsg ? '${nicPip.properties.ipConfigurations[0].properties.privateIPAddress}' : '${nicNoPip.properties.ipConfigurations[0].properties.privateIPAddress}' 
