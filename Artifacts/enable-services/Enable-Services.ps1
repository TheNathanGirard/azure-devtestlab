
Write-Output "Enabling Services"
Get-Service -Name com.docker.service | Set-Service -StartupType Automatic
Get-Service -Name docker | Set-Service -StartupType Automatic