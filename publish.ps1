param(
    [string]$Message = ""
)

$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

function Invoke-Git {
    git @args
    if ($LASTEXITCODE -ne 0) {
        throw "git $args failed with exit code $LASTEXITCODE."
    }
}

$branch = (git branch --show-current).Trim()
if ($LASTEXITCODE -ne 0) {
    throw "Cannot detect the current Git branch."
}

if ([string]::IsNullOrWhiteSpace($branch)) {
    throw "Cannot detect the current Git branch."
}

Invoke-Git fetch origin

$changes = git status --porcelain
if ($LASTEXITCODE -ne 0) {
    throw "Cannot read Git status."
}

if ([string]::IsNullOrWhiteSpace($changes)) {
    Invoke-Git pull --rebase origin $branch
    Write-Host "No local changes to publish. Local branch is up to date."
    exit 0
}

if ([string]::IsNullOrWhiteSpace($Message)) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Message = "Update site $timestamp"
}

Invoke-Git add -A
Invoke-Git commit -m $Message
Invoke-Git pull --rebase origin $branch
Invoke-Git push origin $branch

Write-Host "Published to GitHub Pages from branch '$branch'."
