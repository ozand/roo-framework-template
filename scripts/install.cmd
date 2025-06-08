@echo off
:: Roo Framework Installer v2.0 (Safe Edition) - PowerShell Loader
:: This batch file simply ensures that the PowerShell script can be executed.

ECHO --- Roo Framework Safe Installer ---
ECHO This will run a PowerShell script to safely install the framework.

FOR /F "tokens=*" %%P IN ('powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-Variable PSVersionTable -ValueOnly).PSVersion.Major"') DO SET PS_VERSION=%%P

IF NOT "%PS_VERSION%" GEQ "5" (
    ECHO ERROR: PowerShell 5.0 or higher is required.
    ECHO Please update PowerShell and try again.
    GOTO :eof
)

:: Execute the PowerShell script content embedded within this batch file
powershell -NoProfile -ExecutionPolicy Bypass -Command ". { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $script = (Get-Content '%~f0' | Out-String); iex ($script.Substring($script.IndexOf('BEGIN_POWERSHELL_SCRIPT') + 25)) }"
GOTO :eof

<#
.SYNOPSIS
    Safely installs the Roo Framework by downloading it to a temporary location and copying only essential files.

.DESCRIPTION
    This script performs the following actions:
    1. Creates a unique temporary directory.
    2. Downloads the latest version of the framework from GitHub as a ZIP archive.
    3. Extracts the archive.
    4. Copies the necessary framework files (.roo directory and .roomodes file) into the current directory.
    5. Cleans up by deleting the temporary directory and downloaded archive.

BEGIN_POWERSHELL_SCRIPT

$ErrorActionPreference = 'Stop'

# --- Configuration ---
$RepoUrl = "https://github.com/ozand/roo-framework-template/archive/refs/heads/main.zip"

# --- Main Logic ---
$DestDir = Get-Location
Write-Host "Installation Target: $($DestDir.Path)"

# 2. Create a temporary directory
$TempDir = Join-Path $env:TEMP $([System.Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $TempDir | Out-Null

Write-Host "Downloading framework to a temporary location..."

# 3. Download and Unzip
$ZipFile = Join-Path $TempDir "framework.zip"
Invoke-WebRequest -Uri $RepoUrl -OutFile $ZipFile
Expand-Archive -Path $ZipFile -DestinationPath $TempDir

# 4. Find the source directory
$SourceDirParent = Get-ChildItem -Path $TempDir -Directory -Filter "*roo-framework-template*" | Select-Object -First 1
if (-not $SourceDirParent) {
    Write-Error "Could not find framework directory in the downloaded archive. Installation aborted."
    exit 1
}
$FrameworkFilesSource = Join-Path $SourceDirParent.FullName "framework_files"

if (-not (Test-Path $FrameworkFilesSource)) {
    Write-Error "Could not find 'framework_files' in the downloaded archive. Installation aborted."
    exit 1
}

# 5. Copy framework files
Write-Host "Copying framework files to your project..."

$RooDirSource = Join-Path $FrameworkFilesSource ".roo"
if (Test-Path $RooDirSource) {
    Copy-Item -Path "$RooDirSource\*" -Destination $DestDir -Recurse -Force
}

$RooModesSource = Join-Path $FrameworkFilesSource ".roomodes"
if (Test-Path $RooModesSource) {
    Copy-Item -Path $RooModesSource -Destination $DestDir -Force
}

# 4. Run the build script to assemble prompts from modules
Write-Host "Assembling prompts from modules..."
$BuildScriptPath = Join-Path $DestDir "scripts\build_prompts.py"
if (Test-Path $BuildScriptPath) {
    & python $BuildScriptPath
} else {
    Write-Warning "Build script not found at $BuildScriptPath. Prompts may not be assembled."
}

# 6. Cleanup
Remove-Item -Path $TempDir -Recurse -Force

Write-Host ""
Write-Host "--- Installation Successful! ---"
Write-Host "The Roo framework has been installed in your project."
Write-Host "Please restart your IDE to activate the new modes."

#>