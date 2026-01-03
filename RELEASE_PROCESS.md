# リリースプロセスガイド

新バージョンをリリースする手順を説明します。

## 📋 リリース手順

### 1. リリースブランチで開発

```bash
# 例: v1.0.0 をリリースする場合
git checkout release/v1.0.0
git pull origin release/v1.0.0
```

### 2. CHANGELOG.md を更新

開発中は「未リリース」セクションに変更を記録：

```markdown
## [未リリース]

### 追加
- 新機能の説明

### 修正
- バグ修正の説明
```

### 3. リリース準備

リリース準備ができたら、「未リリース」をバージョン番号に変換：

```markdown
## [1.0.0] - 2025-01-23

### 追加
- 新機能の説明

### 修正
- バグ修正の説明
```

**重要**: バージョン番号は必ずブランチ名と一致させる（`release/v1.0.0` → `[1.0.0]`）

### 4. 変更をコミット・プッシュ

```bash
git add CHANGELOG.md
git commit -m "chore: prepare for v1.0.0 release"
git push origin release/v1.0.0
```

### 5. PR を main にマージ

マージ後、自動で以下が実行されます:
1. タグ作成
2. GitHub Release 作成
3. Cloud Run デプロイ（設定済みの場合）
4. 次のリリースブランチ作成

## 🔢 バージョニング規則

[セマンティックバージョニング](https://semver.org/lang/ja/)に準拠: `MAJOR.MINOR.PATCH`

| 変更内容 | バージョン | 例 |
|---------|-----------|-----|
| バグ修正のみ | PATCH | 1.0.0 → 1.0.1 |
| 新機能追加（後方互換） | MINOR | 1.0.1 → 1.1.0 |
| 破壊的変更 | MAJOR | 1.1.0 → 2.0.0 |

## 📝 CHANGELOG の書き方

### 変更の分類

- **追加**: 新機能
- **変更**: 既存機能の変更
- **非推奨**: 間もなく削除される機能
- **削除**: 削除された機能
- **修正**: バグ修正
- **セキュリティ**: セキュリティ関連の変更

### 良い例

```markdown
## [1.0.0] - 2025-01-23

### 追加
- **バックエンド**: POST /api/v1/todos エンドポイントを追加
- **iOS**: カテゴリ管理機能を実装

### 修正
- **バックエンド**: 認証エラー時のレスポンスを修正
```

## ⚡ クイックコマンド

```bash
# リリースブランチ開始
make release-start

# リリース準備確認
make release-prepare

# リリース状態確認
make release-status
```

## 🔧 トラブルシューティング

### CHANGELOG 検証エラー

```
❌ エラー: CHANGELOG.md にバージョン [X.Y.Z] のセクションが見つかりません
```

**対処法**: CHANGELOG.md のフォーマットを確認 `## [X.Y.Z] - YYYY-MM-DD`

### GitHub Release 作成失敗

**対処法**: リポジトリ設定 > Actions > General > "Workflow permissions" を "Read and write permissions" に設定

## 📚 参考資料

- [セマンティックバージョニング](https://semver.org/lang/ja/)
- [Keep a Changelog](https://keepachangelog.com/ja/1.0.0/)
