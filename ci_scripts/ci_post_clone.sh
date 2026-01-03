#!/bin/sh

# Xcode Cloud: Swift マクロの信頼設定をスキップ
# サードパーティパッケージ (swift-api-contract) のマクロを使用するために必要
defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES
