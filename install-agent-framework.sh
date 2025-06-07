#!/usr/bin/env bash
# Roo Code Agent Framework Installer v1.1

# Выход при ошибке
set -e

echo "--- Deploying Roo Code Cognitive Architecture (macOS/Linux) ---"
echo ""

# Определяем директорию, где находится сам скрипт
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TEMPLATE_DIR="$SCRIPT_DIR"
# Целевая директория - та, откуда пользователь запустил скрипт
DEST_DIR=$(pwd)

echo "Source: $TEMPLATE_DIR"
echo "Destination: $DEST_DIR"
echo ""

# Копируем .roomodes
if [ -f "$TEMPLATE_DIR/.roomodes" ]; then
    echo "Copying .roomodes..."
    cp "$TEMPLATE_DIR/.roomodes" "$DEST_DIR/"
else
    echo "ERROR: .roomodes not found in template directory. Installation failed."
    exit 1
fi

# Копируем директорию .roo
if [ -d "$TEMPLATE_DIR/.roo" ]; then
    echo "Copying .roo directory..."
    # -r для рекурсивного копирования, -T чтобы избежать создания лишней вложенной папки
    cp -rT "$TEMPLATE_DIR/.roo" "$DEST_DIR/.roo"

# Копируем конфигурацию MCP
if [ -f "$DEST_DIR/.roo/mcp.json" ]; then
    echo "Copying MCP server configurations..."
    # No need to copy again as it's inside .roo, just confirm
    echo ".roo/mcp.json included in .roo directory copy."
else
    echo "WARNING: .roo/mcp.json not found after copying .roo directory."
fi
else
    echo "ERROR: .roo directory not found in template directory. Installation failed."
    exit 1
fi

echo ""
echo "--- Installation complete successfully! ---"
echo "Please restart VS Code to activate the new modes (e.g., 'Flow-Code')."