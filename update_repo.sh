#!/bin/bash

# ============================================
# 🚀 ZeroRepo Updater Script by ZeroX-AI 😈🔥
# Automates: build -> repo-add -> sync -> git push
# ============================================

set -e

# --- CONFIGURATION ---
REPO_SRC="$HOME/ZeroRepo"
REPO_DST="/repo/zerorepo/x86_64"
BUILD_SCRIPT="$HOME/build_zerorepo.sh"
COMMIT_MESSAGE="Update packages on $(date +'%Y-%m-%d %H:%M:%S')"
DB_NAME="zerorepo.db.tar.gz"

echo "🔁 Starting ZeroRepo update..."

# --- STEP 1: Run build script ---
echo "⚙️  Running build script..."
if [[ -f "$BUILD_SCRIPT" ]]; then
    bash "$BUILD_SCRIPT"
else
    echo "❌ Build script not found at: $BUILD_SCRIPT"
    exit 1
fi

# --- STEP 2: Generate new repo database ---
echo "📦 Rebuilding local repo database..."
cd "$REPO_SRC/x86_64"
rm -f zerorepo.db* zerorepo.files*
repo-add "$DB_NAME" *.pkg.tar.zst

# --- STEP 3: Sync to /repo/ folder ---
echo "📁 Syncing repository to $REPO_DST..."
sudo mkdir -p "$REPO_DST"
sudo rsync -av --delete "$REPO_SRC/x86_64/" "$REPO_DST/"

# --- STEP 4: Set proper permissions ---
echo "🔐 Fixing permissions..."
sudo chown -R root:root "$REPO_DST"
sudo chmod -R 755 "$REPO_DST"

# --- STEP 5: Git push ---
cd "$REPO_SRC"
echo "🔍 Checking for git changes..."
git lfs track "x86_64/*.pkg.tar.zst"
git add .gitattributes .

if git diff-index --quiet HEAD --; then
    echo "✅ No new git changes."
else
    echo "✅ Committing and pushing changes..."
    git commit -m "$COMMIT_MESSAGE"
    git push origin main
fi

echo "✅ ZeroRepo update complete!"
