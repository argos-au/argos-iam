<# 
.SYNOPSIS
    Create an Azure Active Directory App Registration / Service Principal to be used for ARGOS Cloud Security https://argos-security.io

.DESCRIPTION 
    This script creates an Azure Active Directory App Registration and an Application Secret that can be used to connect ARGOS Cloud Security to Microsoft Azure in order to scan Azure Subscriptions. The secret has a validity of 12 months.
 
.NOTES 
    Best executed in Azure Cloud Shell (https://shell.azure.com) as Cloud Shell is already authenticated to your tenant. User executing this script requires permissions to create an AAD App Registration and permissions to assign IAM Roles to Azure Subscriptions.

.COMPONENT 
    Requires module Az.Resources

.LINK 
    Useful Link to ressources or others.

.Example
    .\create-AzureServicePrincipal.ps1 -DisplayName "ARGOS Cloud Security"
 
.Parameter DisplayName 
    App Registration Name
#>

param(
[Parameter(Mandatory = $true)]
$DisplayName
)

$app = New-AzADServicePrincipal -DisplayName $DisplayName -Homepage https://app.argos-security.io -Description "Principal used for ARGOS Cloud Security" -EndDate $([DateTime]::Now.AddMonths(12))

Write-Host "Before proceeding to ARGOS, ensure the Principal has at least `Reader` permissions to an Azure Subscription or Management Group."
Write-Host "Add the following information into ARGOS on https://app.argos-security.io/account/azure-settings "
Write-Host "Tenant Id: $($app.AppOwnerOrganizationId)"
Write-Host "Application / Client Id: $($app.AppId)"
Write-Host "Application / Client Secret: $($app.PasswordCredentials[0].SecretText)"
