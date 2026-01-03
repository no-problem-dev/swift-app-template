# サポート

## ドキュメント

- [README.md](README.md) - セットアップと使用方法
- [CONTRIBUTING.md](CONTRIBUTING.md) - コントリビューションガイド
- [docs/](docs/) - 追加ドキュメント

## ヘルプを得る

### Issue

バグや機能リクエストは [Issue](../../issues/new/choose) を作成してください。

## よくある問題

### ビルドエラー

1. Xcode 16+ がインストールされているか確認
2. `make setup` でプロジェクトファイルを再生成
3. Xcode でクリーンビルド: `Cmd + Shift + K`

### Firebase セットアップ

1. `GoogleService-Info.plist` が `iOS/App/` にあるか確認
2. plist 追加後に `make xcode-generate` を実行
3. Firebase Console でバンドル ID を確認

### エミュレーター問題

1. Firebase CLI インストール確認: `npm install -g firebase-tools`
2. エミュレーター状態確認: `make emulator-status`
3. ポート解放: `make kill-ports`
