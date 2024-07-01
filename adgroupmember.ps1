# Define the AD group
$adgroup = "CN=Okta SSO for Concur Global,OU=US Security Groups,OU=US Groups,OU=Groups,DC=corp,DC=copart,DC=com"

# Get members of the AD group
$Members = Get-ADGroupMember -Identity $adgroup
$totalcount = ($Members | Measure-Object).Count
$count = 1
# Loop through each member and retrieve their details
ForEach ($member in $Members) {
    # Get the user details including userprincipalname
    $user = Get-ADUser -Identity $member.SamAccountName -Properties userprincipalname
     # Output the member's name
    
    write-host "Collecting data for '$count' of Total '$totalcount'"
    write-host "Collecting data for", " $($user.Name)" -ForegroundColor Red
    Write-Host "$($user.Name)'s email address is $($user.UserPrincipalName)" -ForegroundColor Green
    $count++
}
write-host "Total count is '$usercount'"