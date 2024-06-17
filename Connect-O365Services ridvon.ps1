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

    Write-Host "Connected to Exchange online as $UserPrincipalName"
    Write-Host " "

    # Install AzureAD module if not already installed
    if (-not (Get-Module AzureAD -ListAvailable)) {
        Install-Module -Name AzureAD -Force -Scope CurrentUser
    }

    # Import AzureAD module
    Import-Module AzureAD -Force

    # Connect to Azure AD
    Connect-AzureAD -TenantId "120d4d82-9be2-46a5-b49c-1db839913ac5" -Credential $Credentials
    Write-Host "Connected to Azure AD as $UserPrincipalName" -ForegroundColor Green -BackgroundColor Red
    Write-Host " "

    # Microsoft teams Connect
    
    Import-Module MicrosoftTeams
    
    Connect-MicrosoftTeams
    Write-Host "Connected to Teams as $UserPrincipalName" -ForegroundColor Green -BackgroundColor Red
    Write-Host " "

    Connect-AzAccount -Credential $Credentials -Force -Tenant "120d4d82-9be2-46a5-b49c-1db839913ac5" -ForegroundColor Green -BackgroundColor Red
    Write-Host "Connected to Azure as $UserPrincipalName" -ForegroundColor Green -BackgroundColor Red
    Write-Host " "

    #Write-Host "Connected to Azure, Microsoft Defender, Microsoft Cloud App Security, and Microsoft Teams as $UserPrincipalName"
}
