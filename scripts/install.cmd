@echo off
rem Framework Installer v1.0
echo --- Framework Installer ---

rem 1. Define directories
rem The directory where the script itself is located
set "SCRIPT_DIR=%~dp0"
rem Path to the framework files relative to the script
set "TEMPLATE_DIR=%SCRIPT_DIR%..\framework_files"
rem The target directory is where the user ran the script from
set "DEST_DIR=%CD%"

echo Template source: %TEMPLATE_DIR%
echo Installation target: %DEST_DIR%
echo.

rem 2. Check that the template files are in place
if not exist "%TEMPLATE_DIR%\.roo" (
echo ERROR: .roo directory not found. Installation aborted.
exit /b 1
)
if not exist "%TEMPLATE_DIR%\.roomodes" (
echo ERROR: .roomodes file not found. Installation aborted.
exit /b 1
)

rem 3. Copy framework files to the destination directory
echo Copying .roo directory...
xcopy /E /I /Y "%TEMPLATE_DIR%\.roo" "%DEST_DIR%\.roo"

echo Copying .roomodes file...
copy /Y "%TEMPLATE_DIR%\.roomodes" "%DEST_DIR%\"

echo.
echo --- Installation successful! ---
echo Please restart your IDE to activate the new modes.