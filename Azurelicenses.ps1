# Install the Microsoft Graph module if not already installed
Install-Module -Name Microsoft.Graph -Force -AllowClobber

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.Read.All"

# Define the output file
$outputFile = "ExternalUsers.csv"

# Initialize an array to store user data
$externalUsers = @()

# Get all users and filter for guest users
$users = Get-MgUser -Filter "userType eq 'Guest'" -All

foreach ($user in $users) {
    # Create a custom object to hold user data
    $userObject = [PSCustomObject]@{
        DisplayName        = $user.DisplayName
        UserPrincipalName  = $user.UserPrincipalName
        Email              = $user.Mail
        InvitedBy          = $user.InvitedByUser
        CreationDate       = $user.CreatedDateTime
    }
    
    # Add the user object to the array
    $externalUsers += $userObject
}

# Export user data to CSV
$externalUsers | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "External user data has been exported to $outputFile"
