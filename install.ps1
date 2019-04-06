$ErrorActionPreference = "Stop"
Set-StrictMode -Version 5.0

function New-SymbolicLink([string]$Path, [string]$Target) {

    try {
        $Path = (Resolve-Path $Path).ProviderPath

        # We should have thrown an error, but didn't.
        Write-Warning "$Path already exists. Not creating symbolic link."
        return

    } catch {
        # This is expected.
        $Path = $_.TargetObject
    }

    $Target = (Resolve-Path $Target).ProviderPath
    # $Target SHOULD exist, so we don't have to do funny try / catch stuff as above

    cmd /c mklink $Path $Target
    $result = $LASTEXITCODE
    if ($result -ne 0) {
        throw "mklink exited with code $result"
    }
}

New-SymbolicLink "~\.gitconfig" "$PSScriptRoot\git\.gitconfig"
