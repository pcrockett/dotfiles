$ErrorActionPreference = "Stop"
Set-StrictMode -Version 5.0

function New-SymbolicLink([string]$Path, [string]$Target, [switch]$Force) {

    $linkPathAlreadyExists = $false
    try {
        $Path = (Resolve-Path $Path).ProviderPath

        # Because we made it here, we know the path already exists
        $linkPathAlreadyExists = $true

    } catch {
        # This is expected.
        $Path = $_.TargetObject
    }

    $Target = (Resolve-Path $Target).ProviderPath
    # $Target SHOULD exist, so we don't have to do funny try / catch stuff as above

    if ($linkPathAlreadyExists) {
        if ($Force) {
            Remove-Item $Path
        } else {
            Write-Warning "$Path already exists. Not creating symbolic link."
            return
        }
    }

    New-Item -ItemType HardLink -Path $Path -Value $Target
    # I know this isn't actually a symbolic link... those require admin
    # privileges on Windows unfortunately. Hard links should do the trick though!
}

New-SymbolicLink "~\.gitconfig" "$PSScriptRoot\git\.gitconfig"

$winPowDir = Split-Path $PROFILE.CurrentUserAllHosts
if (!(Test-Path $winPowDir)) {
    New-Item -Type Directory $winPowDir
}
New-SymbolicLink $PROFILE.CurrentUserAllHosts "$PSScriptRoot\powershell\profile.ps1"

& "$PSScriptRoot\vscode\install.ps1"
