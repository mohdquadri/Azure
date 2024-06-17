    $Credentials = Get-Credential -UserName rizwan.quadri@copart.com -Message "Enter your credentials"
 # Install Exchange Online Management Module if not already installed
    if (-not (Get-Module ExchangeOnlineManagement -ListAvailable)) {
        Install-Module -Name ExchangeOnlineManagement -Force -Scope CurrentUser
    }

    # Import Exchange Online Management Module
    Import-Module ExchangeOnlineManagement -Force
    
    # Connect to Exchange Online
    Connect-ExchangeOnline -UserPrincipalName rizwan.quadri@copart.com -ShowProgress $true

    Write-Host "Connected to Office 365 as $UserPrincipalName"
    write-host " "

    Get-mailbox -ResultSize unlimited | Measure-Object
    get-mailbox -ResultSize unlimited | Get-MailboxStatistics | fl *totalitemsize*, displayname


    
    #Azure CLI cmdlet to get the employees list from Azure portal
    #Get-AzADUser -Filter "UserType eq 'Member'" | Where-Object { $_.UserPrincipalName -like "*@copart.com*" } | where {$_.userprincipalname -notlike "*kiosk*"} | Select-Object DisplayName, UserPrincipalName, UserType