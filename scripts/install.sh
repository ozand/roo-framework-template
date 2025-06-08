#!/usr/bin/env bash
# Roo Framework Installer v2.0 (Safe Edition)
# This script downloads the framework to a temporary directory, copies essential files, and then cleans up.
set -e

# --- Configuration ---
REPO_URL="https://github.com/ozand/roo-framework-template/archive/refs/heads/main.zip"

# --- Main Logic ---
echo "--- Roo Framework Safe Installer ---"

# 1. Define destination directory (where the user ran the script)
DEST_DIR=$(pwd)
echo "Installation Target: $DEST_DIR"

# 2. Create a temporary directory
TEMP_DIR=$(mktemp -d)
# Ensure cleanup happens on script exit
trap "rm -rf $TEMP_DIR" EXIT

echo "Downloading framework to a temporary location..."

# 3. Download and Unzip
curl -L "$REPO_URL" -o "$TEMP_DIR/framework.zip"
unzip -q "$TEMP_DIR/framework.zip" -d "$TEMP_DIR"

# 4. Find the source directory (it's usually named 'repo-branch')
# Use a wildcard to find the unzipped directory without hardcoding the branch name.
SOURCE_DIR_PARENT=$(find "$TEMP_DIR" -mindepth 1 -maxdepth 1 -type d -name "*roo-framework-template*")
FRAMEWORK_FILES_SOURCE="$SOURCE_DIR_PARENT/framework_files"

if [ ! -d "$FRAMEWORK_FILES_SOURCE" ]; then
    echo "ERROR: Could not find 'framework_files' in the downloaded archive. Installation aborted."
    exit 1
fi

# 5. Copy framework files to the destination directory
echo "Copying framework files to your project..."

# Copy .roo directory
if [ -d "$FRAMEWORK_FILES_SOURCE/.roo" ]; then
    cp -rT "$FRAMEWORK_FILES_SOURCE/.roo" "$DEST_DIR/.roo"
fi

# Copy .roomodes file
if [ -f "$FRAMEWORK_FILES_SOURCE/.roomodes" ]; then
    cp "$FRAMEWORK_FILES_SOURCE/.roomodes" "$DEST_DIR/"
fi

echo ""
echo "--- Installation Successful! ---"
echo "The Roo framework has been installed in your project."
echo "Please restart your IDE to activate the new modes."