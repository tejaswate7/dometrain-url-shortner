param location string = resourceGroup().location

var uniqueId = uniqueString(resourceGroup().id)

module keyVault 'modules/secrets/keyvault.bicep' = {
  name: 'keyVaultDeployment'
  params: {
    location: location
    vaultName: 'kv-${uniqueId}'
}
}

module apiService 'modules/compute/appservice.bicep' = {
  name: 'apiDeployment'
  params: {
    location: location
    appServicePlanName: 'plan-api-${uniqueId}'
    appName: 'api-${uniqueId}'
    keyVaultName: keyVault.outputs.name
  }
  dependsOn: [
    keyVault
  ]
}

module keyVaultRoleAssignment 'modules/secrets/key-vault-role-assignment.bicep' = {
  name: 'keyVaultRoleAssignmentDeployment'
  params: {
    keyVaultName: keyVault.outputs.name
    principalIds: [
      apiService.outputs.principalId
    ]
}
dependsOn: [
  keyVault
  apiService
]
}
