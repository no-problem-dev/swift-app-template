#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
IOS_DIR="$PROJECT_ROOT/iOS"
PLIST_PATH="$IOS_DIR/App/GoogleService-Info.plist"
PROJECT_YML="$IOS_DIR/project.yml"
CONFIG_FILE="$PROJECT_ROOT/setup.config"

echo "🔧 Generating project.yml..."

# setup.config の存在確認
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ setup.config not found"
    echo ""
    echo "📋 Setup steps:"
    echo "   1. cp setup.config.example setup.config"
    echo "   2. Edit setup.config with your values"
    echo "   3. Run make setup again"
    exit 1
fi

# setup.config を読み込み
source "$CONFIG_FILE"

# 必須項目の確認
if [ -z "$APP_NAME" ] || [ -z "$BUNDLE_ID" ]; then
    echo "❌ APP_NAME and BUNDLE_ID are required in setup.config"
    exit 1
fi

# GoogleService-Info.plist の存在確認
if [ ! -f "$PLIST_PATH" ]; then
    echo "❌ GoogleService-Info.plist not found at: $PLIST_PATH"
    echo ""
    echo "📋 Setup steps:"
    echo "   1. Download GoogleService-Info.plist from Firebase Console"
    echo "   2. Place it in iOS/App/GoogleService-Info.plist"
    echo "   3. Run this script again"
    exit 1
fi

# REVERSED_CLIENT_ID を抽出
REVERSED_CLIENT_ID=$(/usr/libexec/PlistBuddy -c "Print :REVERSED_CLIENT_ID" "$PLIST_PATH" 2>/dev/null)

if [ -z "$REVERSED_CLIENT_ID" ]; then
    echo "❌ REVERSED_CLIENT_ID not found in GoogleService-Info.plist"
    exit 1
fi

echo "  ✅ Config: $APP_NAME ($BUNDLE_ID)"
echo "  ✅ Found REVERSED_CLIENT_ID"

# デフォルト値設定
APP_DISPLAY_NAME="${APP_DISPLAY_NAME:-$APP_NAME}"
BUNDLE_ID_PREFIX="${BUNDLE_ID_PREFIX:-com.example}"
DEVELOPMENT_TEAM="${DEVELOPMENT_TEAM:-}"

# project.yml を生成
cat > "$PROJECT_YML" << EOF
name: $APP_NAME
options:
  bundleIdPrefix: $BUNDLE_ID_PREFIX
  deploymentTarget:
    iOS: "17.0"
  xcodeVersion: "16.0"
  generateEmptyDirectories: true

settings:
  base:
    SWIFT_VERSION: "6.0"
    ENABLE_USER_SCRIPT_SANDBOXING: false

packages:
  Presentation:
    path: Packages/Presentation
  UseCases:
    path: Packages/UseCases

targets:
  $APP_NAME:
    type: application
    platform: iOS
    sources:
      - path: App/Sources
      - path: App/GoogleService-Info.plist
    dependencies:
      - package: Presentation
      - package: UseCases
    settings:
      base:
        INFOPLIST_FILE: App/Info.plist
        PRODUCT_BUNDLE_IDENTIFIER: $BUNDLE_ID
        MARKETING_VERSION: "1.0.0"
        CURRENT_PROJECT_VERSION: "1"
        ASSETCATALOG_COMPILER_APPICON_NAME: AppIcon
        CODE_SIGN_STYLE: Automatic
        DEVELOPMENT_TEAM: "$DEVELOPMENT_TEAM"
    info:
      path: App/Info.plist
      properties:
        CFBundleURLTypes:
          - CFBundleTypeRole: Editor
            CFBundleURLSchemes:
              - $REVERSED_CLIENT_ID
        CFBundleDisplayName: $APP_DISPLAY_NAME
        CFBundleShortVersionString: "1.0.0"
        CFBundleVersion: "1"
        UILaunchScreen:
          UIColorName: ""
          UIImageName: ""
        UISupportedInterfaceOrientations:
          - UIInterfaceOrientationPortrait
        UISupportedInterfaceOrientations~ipad:
          - UIInterfaceOrientationPortrait
          - UIInterfaceOrientationPortraitUpsideDown
          - UIInterfaceOrientationLandscapeLeft
          - UIInterfaceOrientationLandscapeRight
    entitlements:
      path: App/App.entitlements
      properties:
        com.apple.developer.applesignin:
          - Default
EOF

echo "  ✅ Generated project.yml"

# xcodegen を実行
echo "📱 Running xcodegen..."
cd "$IOS_DIR" && xcodegen generate

echo ""
echo "🎉 Setup complete!"
echo "   Open AppTemplate.xcworkspace in Xcode"
