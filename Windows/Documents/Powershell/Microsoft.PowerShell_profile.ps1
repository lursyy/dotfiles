# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Disable Bell
Set-PSReadLineOption -BellStyle None

# only notify for major updates (this setting doesn't work for me though)
$env:POWERSHELL_UPDATECHECK = 'LTS'

# Import Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# posh-git: tab completion and status
# NOTE: this has to be installed first via Powershell Gallery
Import-Module posh-git

# gsudo: !! (bang bang) support
Import-Module "C:\tools\gsudo\Current\gsudoModule.psd1"