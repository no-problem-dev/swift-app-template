#!/bin/bash
# リリース状況を確認

set -e

echo "📊 Release Status Report"
echo "========================="
echo ""

git fetch --prune origin >/dev/null 2>&1

CURRENT=$(git branch --show-current)
LATEST_RELEASE=$(git branch -r | grep 'origin/release/' | sed 's|.*origin/||' | sort -V | tail -1)
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "none")

echo "🌿 Current Branch: $CURRENT"
echo "🏷️  Latest Release Branch: $LATEST_RELEASE"
echo "🔖 Latest Tag: $LATEST_TAG"
echo ""

echo "📋 All Release Branches:"
git branch -r | grep 'origin/release/' | sed 's|.*origin/||' | sort -V | nl -w2 -s'. '
echo ""

if [ -f "CHANGELOG.md" ]; then
    echo "📝 CHANGELOG.md Status:"
    if grep -q "## \[未リリース\]" CHANGELOG.md; then
        echo "  ✅ 未リリース section exists"
        echo "  📄 Unreleased changes:"
        sed -n '/## \[未リリース\]/,/## \[/p' CHANGELOG.md | head -20 | sed 's/^/     /'
    else
        echo "  ⚠️  No 未リリース section found"
        echo "  💡 Run: make release-prepare"
    fi
else
    echo "❌ CHANGELOG.md not found"
fi

echo ""

if [ "$CURRENT" = "$LATEST_RELEASE" ]; then
    echo "✅ You are on the latest release branch"
else
    echo "⚠️  You are NOT on the latest release branch"
    echo "💡 Run: make release-start"
fi
