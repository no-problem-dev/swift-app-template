# コントリビューションガイド

## 開発フロー

1. リポジトリをフォーク
2. ローカルにクローン
3. [README.md](README.md) に従ってセットアップ

## ブランチ命名規則

- `feature/` - 新機能
- `fix/` - バグ修正
- `docs/` - ドキュメント更新
- `refactor/` - リファクタリング

## コミットメッセージ

[Conventional Commits](https://www.conventionalcommits.org/) に従う:

```
feat: ユーザー認証を追加
fix: ログインタイムアウトを修正
docs: セットアップ手順を更新
```

## プルリクエスト

1. `main` からブランチを作成
2. 変更をコミット
3. テストが通ることを確認
4. PRを作成

## コードスタイル

- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/) に従う
- Clean Architecture の原則を維持
- `let` を `var` より優先

## テスト実行

```bash
# iOS
/ios-dev:ios-test

# Server
make server-test
```

## ライセンス

コントリビューションは MIT License の下でライセンスされます。
