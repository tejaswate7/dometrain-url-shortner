param location string = resourceGroup().location
param appServicePlanName string
param appName string

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  kind: 'linux'
  sku: {
    name: 'B1'
}
}

resource webApp 'Microsoft.Web/sites@2024-04-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
    }
  }
}

resource webAppConfig 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: webApp
  name: 'web'
  properties: {
    scmType: 'GitHub'
  }
}

output appServiceId string = webApp.id
