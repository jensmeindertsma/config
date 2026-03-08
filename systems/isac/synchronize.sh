#!/usr/bin/env bash
set -euo pipefail

# Resolve the directory the script is in
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Repo path relative to the script
REPO="$SCRIPT_DIR/system"

# Temporary test deployment directory
TARGET="/"

# Function to copy a single file and create parent directories
copy_file() {
    local src="$1"
    local dest="$2"

    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    chmod --reference="$src" "$dest"   # preserve permissions
}

echo "Deploying files from $REPO to $TARGET..."

# Loop over all files in the repo
find "$REPO" -type f | while read -r file; do
    # Strip repo prefix and prepend target directory
    relpath="${file#$REPO/}"
    dest="$TARGET$relpath"

    echo "Copying $file → $dest"
    copy_file "$file" "$dest"
done

echo "✅ Deployment to $TARGET complete."
