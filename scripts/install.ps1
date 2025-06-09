# Roo Framework Installer v3.0 (Local Copy PowerShell Edition)
# This script copies essential framework files from a local template repository into the current directory.

$ErrorActionPreference = 'Stop'

# --- Main Logic ---
Write-Host "--- Roo Framework Installer ---"

# 1. Define Source and Destination Directories
$ScriptDir = $PSScriptRoot
$TemplateFilesDir = Join-Path $ScriptDir "..\framework_files"
$DestDir = Get-Location

# Sanity check: prevent running inside the template directory
if ($DestDir.Path -like "$($ScriptDir)*") {
    Write-Error "ERROR: Do not run this script from inside the template's own scripts directory."
    Write-Host "Please 'cd' to your new project directory and run the script from there."
    exit 1
}

Write-Host "Template Source: $TemplateFilesDir"
Write-Host "Installation Target: $($DestDir.Path)"
Write-Host ""

# 2. Check if source files exist
$RooDirSource = Join-Path $TemplateFilesDir ".roo"
$RooModesSource = Join-Path $TemplateFilesDir ".roomodes"

if ((-not (Test-Path $RooDirSource)) -or (-not (Test-Path $RooModesSource))) {
    throw "Source framework files not found in '$TemplateFilesDir'. Ensure the template is intact. Installation aborted."
}

# 3. Copy framework files
Write-Host "Copying framework files to your project..."

# Copy .roo directory
Copy-Item -Path "$RooDirSource" -Destination $DestDir -Recurse -Force

# Copy .gitignore file
Copy-Item -Path (Join-Path $TemplateFilesDir ".gitignore") -Destination $DestDir -Force

# Copy .roomodes file
Copy-Item -Path $RooModesSource -Destination $DestDir -Force

# Copy scripts directory
Copy-Item -Path (Join-Path $ScriptDir "..\scripts") -Destination $DestDir -Recurse -Force

# Copy modules directory
Copy-Item -Path (Join-Path $ScriptDir "..\modules") -Destination (Join-Path $DestDir "modules") -Recurse -Force

# Copy guides directory
Copy-Item -Path (Join-Path $ScriptDir "..\guides") -Destination (Join-Path $DestDir "guides") -Recurse -Force

# 4. Run the build script to assemble prompts from modules
Write-Host "Assembling prompts from modules..."
$BuildScriptPath = Join-Path $DestDir "scripts\build_prompts.py"
if (Test-Path $BuildScriptPath) {
    python $BuildScriptPath
} else {
    Write-Warning "Build script not found at $BuildScriptPath. Prompts may not be assembled."
}

Write-Host ""
Write-Host "--- Installation Successful! ---"
Write-Host "Please restart your IDE to activate the new modes."