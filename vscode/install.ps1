$ErrorActionPreference = "Stop"
Set-StrictMode -Version 5.0

$vsCodeUserDir = Join-Path $env:APPDATA "Code\User"
if (!(Test-Path $vsCodeUserDir)) {
    New-Item -Type Directory $vsCodeUserDir | Out-Null
}

New-SymbolicLink "$vsCodeUserDir\settings.json" "$PSScriptRoot\settings.json"
New-SymbolicLink "$vsCodeUserDir\keybindings.json" "$PSScriptRoot\keybindings.json"

$snippetsDir = Join-Path $vsCodeUserDir "snippets"
Get-ChildItem "$PSScriptRoot\snippets" `
    | Where-Object { $_ -is [IO.FileInfo] -and $_.Extension -eq ".json" } `
    | ForEach-Object {
        New-SymbolicLink "$snippetsDir\$($_.Name)" $_.FullName
    }

if (!(Get-Command code -ErrorAction SilentlyContinue)) {
    Write-Warning """code"" command not found. Install VS Code and get it on PATH, then re-run this script."
    return
}

function Invoke-Code() {
    code $args
    $result = $LASTEXITCODE
    if ($result -ne 0) {
        throw """code $args"" exited with code $result"
    }
}

$installedExtensions = @(Invoke-Code --list-extensions | Where-Object { $_ })
$desiredExtensions = @(Get-Content "$PSScriptRoot\extensions.txt" `
    | Where-Object { $_ } `
    | Select-Object -Unique)

$toBeInstalled = $desiredExtensions | Where-Object {
    $installedExtensions -notcontains $_
}

$toBeInstalled | ForEach-Object {
    Invoke-Code --install-extension $_
}

if ($toBeInstalled) {
    Write-Host -ForegroundColor Green "If VS Code is already open, restart it."
}
