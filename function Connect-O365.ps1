function Connect-O365Services {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$UserPrincipalName
    )

    # Prompt for credentials once
    $Credentials = Get-Credential -UserName $UserPrincipalName -Message "Enter your credentials"


    # Install Exchange Online Management Module if not already installed
    if (-not (Get-Module ExchangeOnlineManagement -ListAvailable)) {
        Install-Module -Name ExchangeOnlineManagement -Force -Scope CurrentUser
    }

    # Import Exchange Online Management Module
    Import-Module ExchangeOnlineManagement -Force
    
    # Connect to Exchange Online
    Connect-ExchangeOnline -UserPrincipalName $UserPrincipalName -ShowProgress $true

    Write-Host "Connected to Office 365 as $UserPrincipalName"

    # Install AzureAD module if not already installed
    if (-not (Get-Module AzureAD -ListAvailable)) {
        Install-Module -Name AzureAD -Force -Scope CurrentUser
    }

    # Import AzureAD module
    Import-Module AzureAD -Force

    # Connect to Azure AD
    Connect-AzureAD -TenantId "6b53e62a-045a-4207-9667-0f80bddbeaec" -Credential $Credentials

    # Microsoft teams Connect
    Install-Module -Name MicrosoftTeams -Scope CurrentUser -Confirm $false
    Import-Module MicrosoftTeams
    Connect-MicrosoftTeams
    Connect-AzAccount -Credential $Credentials -Force -Tenant "6b53e62a-045a-4207-9667-0f80bddbeaec"
  

    #Write-Host "Connected to Azure, Microsoft Defender, Microsoft Cloud App Security, and Microsoft Teams as $UserPrincipalName"
}
