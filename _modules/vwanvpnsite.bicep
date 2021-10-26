param location string
param userId int
param name string
param asn int
param bgpIp string
param publicIp string
param vWanId string
param vpnGatewayName string

resource vpnSite 'Microsoft.Network/vpnSites@2021-02-01' = if(userId != 14) {
  name: name
  location: location
  properties: {
    vpnSiteLinks: [
      {
        name: name
        properties: {
          fqdn: publicIp
          bgpProperties: {
            asn: asn
            bgpPeeringAddress: bgpIp
          }
          linkProperties: {
            linkProviderName: 'MicrosoftVpn'
            linkSpeedInMbps: 100
          }
        }
      }
    ]
    deviceProperties: {
      deviceVendor: 'Microsoft'
    }
    virtualWan: {
      id: vWanId
    }
  }
}

resource vpnSitesLink 'Microsoft.Network/vpnGateways/vpnConnections@2021-03-01' = if(userId != 14) {
  name: '${vpnGatewayName}/Connection-${asn}'
  properties: {
    vpnLinkConnections: [
      {
        name: 'Connection-${name}'
        properties: {
          enableBgp: true
          sharedKey: 'MicrosoftMicroHack@1234$'
          vpnSiteLink: {
            id: vpnSite.properties.vpnSiteLinks[0].id
          }
        }
      }
    ]
    remoteVpnSite: {
      id: vpnSite.id
    }
  }
}

output vpnSiteId string = vpnSite.id
