# App Template

## 構造

```
iOS/      - SwiftUI アプリ
Backend/  - Swift Server
Shared/   - 共有ドメインモデル
```

## コマンド

- `make server-run` / `make emulator` - ローカル開発
- `/ios-dev:ios-check` / `/ios-dev:ios-build` - iOS開発

## 設計原則

- **Clean Architecture**: Shared → UseCases → Presentation
- **DI**: Protocol-based dependency injection
- **Statable**: @Statable マクロによる状態管理

## 命名規則

| 対象 | 規則 | 例 |
|------|------|-----|
| DB | snake_case | `todos` |
| Swift型 | PascalCase | `Todo` |
| Swift変数 | camelCase | `categoryId` |
| API | kebab-case | `/v1/todos` |

## SPM パッケージ

- `swift-api-contract` - API定義
- `swift-api-client` - HTTPクライアント
- `swift-authentication` - Firebase認証
- `swift-statable` - 状態管理
- `swift-design-system` - UIコンポーネント
- `swift-ui-routing` - ナビゲーション
- `swift-api-server` - サーバーフレームワーク
- `swift-firebase-server` - Firestore/Auth
- `swift-env` - 環境変数
