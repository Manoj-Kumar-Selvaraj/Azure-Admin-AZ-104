param location string = resourceGroup().location
param environment string = 'dev'
param storageAccountName string = 'sta${uniqueString(resourceGroup().id)}'
// Flag to enable customer-managed key (CMK) encryption
param useCmk bool = false
param keyVaultUri string = ''
param keyName string = ''
param keyVersion string = ''
param forceUpdateTag string = newGuid()

// Storage Account configuration
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
    encryption: {
      keySource: useCmk ? 'Microsoft.Keyvault' : 'Microsoft.Storage'
      keyvaultproperties: useCmk ? {
        keyvaulturi: keyVaultUri
        keyname: keyName
        keyversion: keyVersion
      } : null
      services: {
        blob: { enabled: true }
        file: { enabled: true }
        queue: { enabled: true }
        table: { enabled: true }
      }
    }
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
    accessTier: 'Hot'
  }
  tags: {
    environment: environment
    purpose: 'General Storage'
  }
}

// Blob Service configuration
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: true
  }
}

resource blobLifecycle 'Microsoft.Storage/storageAccounts/managementPolicies@2021-04-01' = {
  name: 'default'
  parent: storageAccount
  properties: {
    policy: {
      rules: [
        {
          enabled: true
          name: 'move-to-cool-and-delete'
          type: 'Lifecycle'
          definition: {
            filters: {
              blobTypes: [ 'blockBlob' ]
              prefixMatch: [ '' ]
            }
            actions: {
              baseBlob: {
                tierToCool: { daysAfterModificationGreaterThan: 30 }
                delete: { daysAfterModificationGreaterThan: 90 }
              }
            }
          }
        }
      ]
    }
  }
}

// Example container
resource exampleContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'mycontainer'
  properties: {
    publicAccess: 'None'
    metadata: {}
  }
}

// Deployment script to upload files
resource copyobject 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'copyScript'
  location: location
  kind: 'AzureCLI'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    azCliVersion: '2.37.0'
    scriptContent: '''
      #!/bin/bash
      echo "Uploading sample data with az CLI..."

      az storage blob upload-batch \
        --account-name $STORAGE_ACCOUNT \
        --destination $CONTAINER \
        --source /mnt/data \
        --auth-mode login
    '''
    retentionInterval: 'P1D'
    cleanupPreference: 'OnSuccess'
    forceUpdateTag: forceUpdateTag
    environmentVariables: [
      {
        name: 'STORAGE_ACCOUNT'
        value: storageAccountName
      }
      {
        name: 'CONTAINER'
        value: 'mycontainer'
      }
    ]
  }
  dependsOn: [
    storageAccount
    exampleContainer
  ]
}

// Outputs
output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
output primaryEndpoint object = storageAccount.properties.primaryEndpoints
