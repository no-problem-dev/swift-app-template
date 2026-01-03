# セキュリティポリシー

## サポートバージョン

| バージョン | サポート状況 |
| ---------- | ------------ |
| 1.x.x      | ✅           |

## 脆弱性の報告

セキュリティ脆弱性を発見した場合:

1. 公開 Issue を作成 **しないでください**
2. GitHub の Private vulnerability reporting を使用
3. 詳細情報を含めてください
4. 修正まで公開を控えてください

## セキュリティベストプラクティス

### Firebase 設定

- `GoogleService-Info.plist` を公開リポジトリにコミットしない
- 本番環境では App Check を有効化

### API セキュリティ

- すべての API エンドポイントは Firebase 認証必須
- 本番環境では HTTPS を使用
- サーバー側で入力を検証

### シークレット管理

- ローカル開発: `.env` ファイル (gitignore済み)
- CI/CD: GitHub Secrets
- 本番: Cloud Secret Manager
