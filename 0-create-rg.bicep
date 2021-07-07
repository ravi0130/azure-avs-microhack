//Sample deployment command : az deployment sub create --location westeurope --template-file .\create-rg.bicep
param weLocation string = 'westeurope'
targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'azure-avs-microhack-rg'
  location: weLocation
}

