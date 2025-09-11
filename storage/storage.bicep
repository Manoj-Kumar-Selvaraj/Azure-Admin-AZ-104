param location string = resourceGroup().location
param environment string = 'dev'
param storageAccountName string = 'sta${uniqueString(resourceGroup().id)}'
// Flag to enable customer-managed key (CMK) encryption
param useCmk bool = false
param keyVaultUri string = ''
param keyName string = ''
param keyVersion string = ''

// Storage Account configuration
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
    name: storageAccountName
    location: location
    sku: {
        name: 'Standard_LRS'  // Can be Standard_LRS, Standard_GRS, Standard_RAGRS, Standard_ZRS, Premium_LRS
    }
    kind: 'StorageV2'      // Can be StorageV2, BlockBlobStorage, FileStorage
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
        accessTier: 'Hot'    // Can be Hot or Cool
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
                // Lifecycle management policy: Move blobs to cool tier after 30 days, delete after 90 days
                // You can customize rules as needed
                // See: https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-policy-configure
                // Add a management policy resource
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
                            prefixMatch: [ '' ] // Applies to all blobs
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

// Outputs
output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
output primaryEndpoint object = storageAccount.properties.primaryEndpoints
