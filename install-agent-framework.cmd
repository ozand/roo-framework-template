@echo off
cls
echo --- Deploying Roo Code Cognitive Architecture (Windows) ---
echo.

:: Устанавливаем директорию, где находится скрипт, как источник
set "TEMPLATE_DIR=%~dp0"
:: Устанавливаем текущую рабочую директорию как цель
set "DEST_DIR=%CD%"

echo Source: %TEMPLATE_DIR%
echo Destination: %DEST_DIR%
echo.

:: Копирование .roomodes
echo Copying .roomodes file...
copy "%TEMPLATE_DIR%.roomodes" "%DEST_DIR%\"
if errorlevel 1 (
    echo ERROR: Failed to copy .roomodes.
    goto :error
)

:: Копирование директории .roo
echo Copying .roo directory...
xcopy "%TEMPLATE_DIR%.roo" "%DEST_DIR%\.roo\" /E /I /Y
if errorlevel 1 (
    echo ERROR: Failed to copy .roo directory.
    goto :error
)

echo Copying MCP server configurations...
copy "%TEMPLATE_DIR%\.roo\mcp.json" "%DEST_DIR%\.roo\"
if errorlevel 1 (
    echo ERROR: Failed to copy .roo directory.
    goto :error
)

echo.
echo --- Installation complete successfully! ---
echo Please restart VS Code to activate the new modes.
goto :eof

:error
echo.
echo --- Installation failed. ---
pause