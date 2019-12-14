#!/usr/bin/env pwsh

function Prompt() {
    Write-Host (Get-Location).Path -ForegroundColor Green
    Write-Host ">" -ForegroundColor DarkGray -NoNewline
    " "
}
