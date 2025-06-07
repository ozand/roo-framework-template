#!/usr/bin/env bash
# Framework Installer v1.0
# Exit on any error
set -e

echo "--- Framework Installer ---"

# 1. Define directories
# The directory where the script itself is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to the framework files relative to the script
TEMPLATE_DIR="$SCRIPT_DIR/../framework_files"
# The target directory is where the user ran the script from
DEST_DIR=$(pwd)

echo "Template source: $TEMPLATE_DIR"
echo "Installation target: $DEST_DIR"
echo ""

# 2. Check that the template files are in place
if [ ! -d "$TEMPLATE_DIR/.roo" ] || [ ! -f "$TEMPLATE_DIR/.roomodes" ]; then
    echo "ERROR: Template files not found in $TEMPLATE_DIR. Installation aborted."
    exit 1
fi

# 3. Copy framework files to the destination directory
echo "Copying .roo directory..."

# The -T key is important to avoid creating an extra nested folder if .roo already exists
cp -rT "$TEMPLATE_DIR/.roo" "$DEST_DIR/.roo"

echo "Copying .roomodes file..."
cp "$TEMPLATE_DIR/.roomodes" "$DEST_DIR/"

echo ""
echo "--- Installation successful! ---"
echo "Please restart your IDE to activate the new modes."