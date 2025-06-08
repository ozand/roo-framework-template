#!/usr/bin/env bash
# Roo Framework Installer v3.0 (Local Copy Edition)
# This script copies essential framework files from a local template repository into the current directory.
set -e

# --- Main Logic ---
echo "--- Roo Framework Installer ---"

# 1. Define Source and Destination Directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_FILES_DIR="$SCRIPT_DIR/../framework_files"
DEST_DIR=$(pwd)

# Sanity check: prevent running inside the template directory
if [[ "$DEST_DIR" == "$SCRIPT_DIR"* ]]; then
    echo "ERROR: Do not run this script from inside the template's own scripts directory."
    echo "Please 'cd' to your new project directory and run the script from there."
    exit 1
fi

echo "Template Source: $TEMPLATE_FILES_DIR"
echo "Installation Target: $DEST_DIR"
echo ""

# 2. Check if source files exist
if [ ! -d "$TEMPLATE_FILES_DIR/.roo" ] || [ ! -f "$TEMPLATE_FILES_DIR/.roomodes" ]; then
    echo "ERROR: Source framework files not found in '$TEMPLATE_FILES_DIR'. Ensure the template is intact. Installation aborted."
    exit 1
fi

# 3. Copy framework files to the destination directory
echo "Copying framework files to your project..."

# Copy .roo directory
cp -rT "$TEMPLATE_FILES_DIR/.roo" "$DEST_DIR/.roo"

# Copy .gitignore file
cp "$TEMPLATE_FILES_DIR/.gitignore" "$DEST_DIR/"

# Copy .roomodes file
cp "$TEMPLATE_FILES_DIR/.roomodes" "$DEST_DIR/"

# 4. Run the build script to assemble prompts
echo "Assembling prompts from modules..."
BUILD_SCRIPT_PATH="$DEST_DIR/scripts/build_prompts.py"
if [ -f "$BUILD_SCRIPT_PATH" ]; then
    python3 "$BUILD_SCRIPT_PATH"
else
    echo "WARNING: Build script not found at $BUILD_SCRIPT_PATH. Prompts may not be assembled."
fi

echo ""
echo "--- Installation Successful! ---"
echo "Please restart your IDE to activate the new modes."