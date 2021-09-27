// adminPassword intentionally left here as this is for demo and ephemeral purpose, no way to hack the world here :)

param vmName string
param location string
param subnetId string
param enableForwarding bool = false
param createPublicIpNsg bool = false
@allowed([
  'Enabled'
  'Disabled'
])
param autoShutdownStatus string = 'Enabled'

@allowed([
  'desktop'
  'server'
])
param osType string

var osServer = {
  publisher: 'MicrosoftWindowsServer'
  offer: 'WindowsServer'
  sku: '2019-Datacenter'
  version: 'latest'
}

var osDesktop = {
  publisher: 'MicrosoftWindowsDesktop'
  offer: 'Windows-10'
  sku: '20h2-ent'
  version: 'latest'
}

module nic 'nic.bicep' = {
  name: '${vmName}-nic'
  params: {
    location: location
    nicName: '${vmName}-nic'
    subnetId: subnetId
    enableForwarding: enableForwarding
    createPublicIpNsg: createPublicIpNsg
    vmName: vmName
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmName
  location: location
  properties: {
    osProfile: {
      adminUsername: 'admin-avs'
      adminPassword: 'MicroHack/123'
      computerName: vmName
    }
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      imageReference: osType == 'desktop' ? osDesktop : osServer
      osDisk: {
        createOption:'FromImage'
        caching:'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        name: '${vmName}-osDisk'
        osType: osType == 'desktop' ? 'Windows' : 'Linux'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary:true
          }
          id: nic.outputs.nicId
        }
      ]
    }
  }
}

resource autoShutdown 'Microsoft.DevTestLab/schedules@2018-09-15' = {
  name: 'shutdown-computevm-${vmName}'
  location: location
  properties: {
    status: autoShutdownStatus
    dailyRecurrence:{
      time: '2100'
    }
    notificationSettings: {
      status:'Disabled'
    }
    taskType: 'ComputeVmShutdownTask'
    targetResourceId: vm.id
    timeZoneId: 'GMT Standard Time'
  }
}

output nicPrivateIp string = nic.outputs.nicPrivateIp
