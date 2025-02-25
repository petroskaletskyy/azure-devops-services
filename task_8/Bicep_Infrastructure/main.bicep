param location string = resourceGroup().location
param appServicePlanName string = 'myAppServicePlan${uniqueString(resourceGroup().id)}'
param webAppName string = 'myWebApp${uniqueString(resourceGroup().id)}'
param sqlServerName string = 'mySqlServer${uniqueString(resourceGroup().id)}'
param sqlDatabaseName string = 'myDatabase'
param sqlAdminLogin string = 'sqladmin'
@secure()
param sqlAdminPassword string

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
}

// Azure Web App
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

// SQL Server
resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdminLogin
    administratorLoginPassword: sqlAdminPassword
    version: '12.0'
  }
}

// SQL  Database
resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-11-01' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    }
  sku: {
    name: 'S0'
    tier: 'Standard'
  }  
}

output webAppUrl string = 'https://${webAppName}.azurewebsites.net'
output sqlServerFqdn string = sqlServer.properties.fullyQualifiedDomainName
