@minLength(3)
@maxLength(24)
param storageAccountName string = 'stgactname001'

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param stgactsku string = 'Standard_LRS'

@allowed([
  'Hot'
  'Cool'
])
param stgactTier string = 'Cool'

param stgactags object = {
  Environment: 'Dev'
  Department: 'IT'
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: resourceGroup().location
  tags: stgactags
  sku: {
    name: stgactsku
  }
  kind: 'StorageV2'
  properties: {
    accessTier: stgactTier
  }
}

output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name
output primaryEndpoints object = storageAccount.properties.primaryEndpoints
