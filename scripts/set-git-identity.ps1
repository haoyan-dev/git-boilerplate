<#
.SYNOPSIS
Sets the Git commit name and email globally or for the current project.
.EXAMPLE
pwsh -File ./scripts/set-git-identity.ps1 haoyan-ts
.EXAMPLE
pwsh -File ./scripts/set-git-identity.ps1 haoyan-dev
.EXAMPLE
pwsh -File ./scripts/set-git-identity.ps1 haoyan-dev project
.NOTES
Scope defaults to global. Project scope requires running inside a Git repository.
Repository-local settings can override global defaults.
This does not change GitHub authentication.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('haoyan-ts', 'haoyan-dev')]
    [string]$Identity,

    [Parameter(Position = 1)]
    [ValidateSet('global', 'project')]
    [string]$Scope = 'global'
)

$ErrorActionPreference = 'Stop'
Get-Command git -ErrorAction Stop | Out-Null

$email = switch ($Identity) {
    'haoyan-ts' { 'haoyan.li@techshare.co.jp' }
    'haoyan-dev' { 'haoyan.li.ac@gmail.com' }
}

$configScope = '--global'
if ($Scope -eq 'project') {
    & git rev-parse --git-dir *> $null
    if ($LASTEXITCODE -ne 0) {
        throw 'Project scope requires running inside a Git repository.'
    }
    $configScope = '--local'
}

& git config $configScope --replace-all user.name $Identity
if ($LASTEXITCODE -ne 0) { throw "Failed to set $Scope Git user.name." }
& git config $configScope --replace-all user.email $email
if ($LASTEXITCODE -ne 0) { throw "Failed to set $Scope Git user.email." }

& git config $configScope --get user.name
if ($LASTEXITCODE -ne 0) { throw "Failed to read $Scope Git user.name." }
& git config $configScope --get user.email
if ($LASTEXITCODE -ne 0) { throw "Failed to read $Scope Git user.email." }
