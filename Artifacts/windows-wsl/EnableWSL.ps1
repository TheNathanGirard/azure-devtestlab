#Requires -RunAsAdministrator
<#
.SYNOPSIS
Enables Windows Subsystem for Linux (WSL) and upgrades WSL to the latest version.

.DESCRIPTION
- Enables the Microsoft-Windows-Subsystem-Linux optional feature
- Prompts for reboot only if required
- Runs 'wsl.exe --upgrade' after WSL is available
#>

Write-Host "=== Windows Subsystem for Linux (WSL) Enablement ===" -ForegroundColor Cyan

# Check current feature state
$feature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

if ($feature.State -ne "Enabled") {
    Write-Host "Enabling Microsoft-Windows-Subsystem-Linux..." -ForegroundColor Yellow

    $result = Enable-WindowsOptionalFeature `
        -Online `
        -FeatureName Microsoft-Windows-Subsystem-Linux `
        -NoRestart `
        -ErrorAction Stop

    if ($result.RestartNeeded) {
        Write-Warning "A system restart is required before WSL can be upgraded."
        Write-Host "Please reboot and re-run this script." -ForegroundColor Red
        exit 3010
    }
}
else {
    Write-Host "Microsoft-Windows-Subsystem-Linux is already enabled." -ForegroundColor Green
}

# Ensure wsl.exe is available
$wslPath = "$env:SystemRoot\System32\wsl.exe"
if (-not (Test-Path $wslPath)) {
    throw "wsl.exe not found. A reboot may still be required."
}

Write-Host "Upgrading WSL..." -ForegroundColor Yellow
& $wslPath --upgrade

if ($LASTEXITCODE -eq 0) {
    Write-Host "WSL upgrade completed successfully." -ForegroundColor Green
}
else {
    throw "WSL upgrade failed with exit code $LASTEXITCODE"
}

Write-Host "=== WSL Setup Complete ===" -ForegroundColor Cyan
