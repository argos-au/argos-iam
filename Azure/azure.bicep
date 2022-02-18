param principalId string

targetScope = 'subscription'

resource iamrole 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' = {
  name: guid(subscription().subscriptionId)
  properties: {
    roleName: 'ARGOS Cloud Security - IAM role'
    description: 'This role allows ARGOS Cloud Security to perform all the READ actions it requires to monitor the configuration of your cloud subscriptions.'
    assignableScopes: [
      subscription().subscriptionId
    ]
    permissions: [
      {
        actions: [
          '*/read'
          'Microsoft.Network/networkWatchers/queryFlowLogStatus/action'
          'Microsoft.Web/sites/config/list/Action'
          'Microsoft.AppConfiguration/configurationStores/ListKeyValue/action'
          'Microsoft.Storage/storageAccounts/queueServices/queues/read'
        ]
      }
    ]
  }
}

resource iamroleAssignment 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
  name: guid(subscription().subscriptionId)
  properties: {
    principalId: principalId
    roleDefinitionId: iamrole.id
    principalType: 'ServicePrincipal'
  }
}
