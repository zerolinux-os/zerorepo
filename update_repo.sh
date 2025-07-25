#!/bin/bash
#
# ZeroRepo Updater Script
# Automates updating the local repo and pushing changes to GitHub.
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
REPO_DIR="$HOME/ZeroRepo"
BUILD_SCRIPT="$HOME/build_zerorepo.sh"
COMMIT_MESSAGE="Update packages on $(date +'%Y-%m-%d %H:%M:%S')"

# --- Main Logic ---

# 1. Run the build script to update local packages
echo "--> Running the build script to fetch and build updates..."
if [ -f "$BUILD_SCRIPT" ]; then
    bash "$BUILD_SCRIPT"
else
    echo "Error: Build script not found at $BUILD_SCRIPT" >&2
    exit 1
fi

# 2. Navigate to the repository directory
cd "$REPO_DIR"

# 3. Ensure git-lfs is tracking the correct files
git lfs track "x86_64/*.pkg.tar.zst"

# 4. Check for changes
if git diff-index --quiet HEAD --; then
    echo "--> No new package updates to commit. Repository is already up-to-date."
    exit 0
fi

# 5. Add, commit, and push the changes
echo "--> Adding changes to Git..."
git add .gitattributes .

echo "--> Committing changes..."
git commit -m "$COMMIT_MESSAGE"

echo "--> Pushing changes to GitHub..."
git push origin main

echo "---"
echo "✅ ZeroRepo update and push complete!"