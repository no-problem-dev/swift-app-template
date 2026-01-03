#!/bin/bash
# リリース準備（CHANGELOG検証）

set -e

echo "🔍 Validating CHANGELOG for release..."
echo ""

CURRENT=$(git branch --show-current)

if ! echo "$CURRENT" | grep -q '^release/v'; then
    echo "❌ Not on a release branch"
    echo "💡 Current branch: $CURRENT"
    echo "💡 Expected: release/vX.Y.Z"
    exit 1
fi

VERSION=$(echo "$CURRENT" | sed 's|release/v||')

echo "📌 Release branch: $CURRENT"
echo "🔢 Version: $VERSION"
echo ""

if [ ! -f "CHANGELOG.md" ]; then
    echo "❌ CHANGELOG.md not found"
    exit 1
fi

echo "📝 Checking CHANGELOG.md..."

if grep -q "## \[$VERSION\]" CHANGELOG.md; then
    echo "  ✅ Version section found: [$VERSION]"
    echo ""
    echo "📄 Release notes preview:"
    echo "─────────────────────────────────────"
    sed -n "/## \[$VERSION\]/,/## \[/p" CHANGELOG.md | head -30
    echo "─────────────────────────────────────"
    echo ""
    echo "✅ Ready for release!"
    echo ""
    echo "📋 Next steps:"
    echo "   1. Review the release notes above"
    echo "   2. Commit if needed: git commit -am 'chore: prepare for v$VERSION release'"
    echo "   3. Push: git push origin $CURRENT"
    echo "   4. Merge PR to main (triggers auto-release)"
elif grep -q "## \[未リリース\]" CHANGELOG.md; then
    echo "  ⚠️  Still has 未リリース section"
    echo ""
    echo "📋 Action required:"
    echo "   1. Replace '## [未リリース]' with '## [$VERSION] - $(date +%Y-%m-%d)'"
    echo "   2. Review and update the changes list"
    echo "   3. Run: make release-prepare again"
else
    echo "  ❌ No version section or 未リリース section found"
    echo ""
    echo "💡 Expected format:"
    echo "   ## [$VERSION] - YYYY-MM-DD"
    echo "   ### 追加"
    echo "   - New feature..."
    exit 1
fi
