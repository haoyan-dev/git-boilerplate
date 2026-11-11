<#
.SYNOPSIS
Sets the global Git commit name and email for a selected identity.
.EXAMPLE
pwsh -File ./scripts/set-git-identity.ps1 haoyan-ts
.EXAMPLE
pwsh -File ./scripts/set-git-identity.ps1 haoyan-dev
.NOTES
Repository-local settings can override these global defaults.
This does not change GitHub authentication.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('haoyan-ts', 'haoyan-dev')]
    [string]$Identity
)

$ErrorActionPreference = 'Stop'
Get-Command git -ErrorAction Stop | Out-Null

$email = switch ($Identity) {
    'haoyan-ts' { 'haoyan.li@techshare.co.jp' }
    'haoyan-dev' { 'haoyan.li.ac@gmail.com' }
}

& git config --global --replace-all user.name $Identity
if ($LASTEXITCODE -ne 0) { throw 'Failed to set global Git user.name.' }
& git config --global --replace-all user.email $email
if ($LASTEXITCODE -ne 0) { throw 'Failed to set global Git user.email.' }

& git config --global --get user.name
if ($LASTEXITCODE -ne 0) { throw 'Failed to read global Git user.name.' }
& git config --global --get user.email
if ($LASTEXITCODE -ne 0) { throw 'Failed to read global Git user.email.' }
