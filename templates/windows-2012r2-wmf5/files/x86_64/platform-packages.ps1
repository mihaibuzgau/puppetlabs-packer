$ErrorActionPreference = "Stop"

. A:\windows-env.ps1

Write-Host "Running Win-2012r2 WMF5.1 Package Customisation"

if (-not (Test-Path "$PackerLogs\DesktopExperience.installed"))
{
  # Enable Desktop experience to get cleanmgr
  Write-Host "Enable Desktop-Experience"
  Add-WindowsFeature Desktop-Experience
  Touch-File "$PackerLogs\DesktopExperience.installed"
  if (Test-PendingReboot) { Invoke-Reboot }
}


if (-not (Test-Path "$PackerLogs\WMF5.installed"))
{
  # Enable Desktop experience to get cleanmgr
  Write-Host "Install WMF5 Patch"
  Install_Win_Patch -PatchUrl "http://buildsources.delivery.puppetlabs.net/windows/wmf5/Win8.1AndW2K12R2-KB3191564-x64.msu"
  Touch-File "$PackerLogs\WMF5.installed"
  Invoke-Reboot
}
