// DOCU
// https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep
// https://learn.microsoft.com/fr-fr/azure/azure-resource-manager/bicep/bicep-config-linter
// https://learn.microsoft.com/fr-fr/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI#prerequisites
// https://learn.microsoft.com/en-us/azure/load-balancer/quickstart-load-balancer-standard-internal-bicep?tabs=CLI
// https://learn.microsoft.com/fr-fr/azure/azure-resource-manager/bicep/add-template-to-azure-pipelines?tabs=CLI


@minLength(3)
@maxLength(24)
@description('Provide a name for the storage account. Use only lower case letters and numbers. The name must be unique across Azure.')
param storageName string

// https://azuretracks.com/2021/04/current-azure-region-names-reference/
param locationCode string = 'northeurope'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'my-vnet'
  location: locationCode
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'Subnet-2'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

resource exampleStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: locationCode
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
