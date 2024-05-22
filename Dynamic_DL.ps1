

# Specify the name or alias of the dynamic distribution group
$GroupName = "corporate.employees@copart.com"

# Get the dynamic distribution group
$Group = Get-DynamicDistributionGroup -Identity $GroupName

# Get the recipient filter of the dynamic distribution group
$RecipientFilter = $Group.RecipientFilter

# Find the members matching the recipient filter
$Members = Get-Recipient -RecipientPreviewFilter $RecipientFilter

# Output the members
$Members | out-file c:\users\riquadri\text.txt

