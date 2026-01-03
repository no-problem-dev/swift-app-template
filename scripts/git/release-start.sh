#!/bin/bash
# 次の開発サイクル開始（リリース後に実行）

set -e

echo "🚀 Starting next development cycle..."
echo ""

git fetch --prune origin

LATEST_RELEASE=$(git branch -r | grep 'origin/release/' | sed 's|.*origin/||' | sort -V | tail -1)

if [ -z "$LATEST_RELEASE" ]; then
    echo "❌ No release branches found"
    echo "💡 Hint: Release branches are auto-created after merging to main"
    exit 1
fi

echo "📌 Latest release branch: $LATEST_RELEASE"

CURRENT_BRANCH=$(git branch --show-current)

if [ "$CURRENT_BRANCH" = "$LATEST_RELEASE" ]; then
    echo "✅ Already on $LATEST_RELEASE"
    git pull origin "$LATEST_RELEASE"
    echo "🎉 Updated to latest version"
    exit 0
fi

echo ""

if git status --porcelain | grep -q .; then
    echo "⚠️  You have uncommitted changes on $CURRENT_BRANCH:"
    git status --short
    echo ""
    echo "💡 Options:"
    echo "   1. Commit: git commit -am 'WIP: your message'"
    echo "   2. Stash: git stash save 'WIP on $CURRENT_BRANCH'"
    echo "   3. Discard: git reset --hard (⚠️ DANGER)"
    exit 1
fi

echo "✅ Working directory clean"
echo ""

git checkout "$LATEST_RELEASE"
git pull origin "$LATEST_RELEASE"

echo ""
echo "🎉 Successfully started development on: $LATEST_RELEASE"
echo ""
echo "📋 Next steps:"
echo "   1. Check CHANGELOG.md for 未リリース section"
echo "   2. Start implementing new features"
echo "   3. Update CHANGELOG.md as you develop"
