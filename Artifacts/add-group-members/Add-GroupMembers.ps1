
Write-Output "Adding users to Hyper-V and Container Groups"
Get-LocalUser | Where-Object -Property Enabled -EQ $true | Add-LocalGroupMember -Group 'Hyper-V Administrators'
Get-LocalUser | Where-Object -Property Enabled -EQ $true | Add-LocalGroupMember -Group 'docker-desktop'