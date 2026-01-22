
Write-Output "Updating Windows Subsystem for Linux Feature"    
# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
Invoke-Command -ScriptBlock { 
    wsl.exe --update
    wsl.exe --set-default-version 2
    wsl.exe --install --no-launch Ubuntu
}

