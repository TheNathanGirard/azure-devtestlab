
Write-Output "Enabling Hyper-V and Container Features"    
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Containers -NoRestart