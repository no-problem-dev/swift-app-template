# 変更履歴

このプロジェクトに対するすべての重要な変更は、このファイルに記録されます。

このフォーマットは [Keep a Changelog](https://keepachangelog.com/ja/1.0.0/) に基づいており、
このプロジェクトは [セマンティック バージョニング](https://semver.org/lang/ja/) に準拠しています。

## [未リリース]

なし

## [0.0.1] - 2026-01-03

### 追加

- 🎉 **初回リリース**: Swift App Template プロジェクト基盤の構築
- 📁 **プロジェクト構造**: iOS アプリと Swift バックエンドのモノレポ構成
- 🧩 **Swift Package Manager**: Clean Architecture パッケージ構成（Shared, UseCases, Presentation）
- 🔥 **Firebase 設定**: Firestore セキュリティルール、インデックス設定
- 🚀 **リリースフロー**: 自動リリース・デプロイワークフローの実装
- 🛠️ **開発環境**: Makefile、環境変数管理、エミュレーター設定

### 技術スタック

- **iOS**: Swift 6.2, iOS 17+, Swift Package Manager
- **バックエンド**: Swift Server (Vapor), Firebase Admin SDK
- **インフラ**: Firebase (Firestore, Auth), Google Cloud Run
- **CI/CD**: GitHub Actions, Xcode Cloud

[未リリース]: https://github.com/no-problem-dev/swift-app-template/compare/v0.0.1...HEAD
[0.0.1]: https://github.com/no-problem-dev/swift-app-template/releases/tag/v0.0.1
