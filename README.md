# Swift App Template

iOS + Swift Backend のフルスタックテンプレート。Clean Architecture、Firebase認証、Firestoreを使用。

## 必要環境

- Xcode 16+
- Swift 6.0+
- XcodeGen (`brew install xcodegen`)
- Firebase CLI (`npm install -g firebase-tools`)

## セットアップ

### 1. リポジトリのクローン

```bash
git clone https://github.com/your-org/swift-app-template.git your-app-name
cd your-app-name
```

### 2. Firebase プロジェクトの設定

1. [Firebase Console](https://console.firebase.google.com/) でプロジェクトを作成
2. iOS アプリを追加し、`GoogleService-Info.plist` をダウンロード
3. `iOS/App/` ディレクトリに配置
4. Authentication で Apple / Google サインインを有効化
5. Firestore Database を作成

### 3. セットアップコマンドの実行

```bash
make setup
```

このコマンドは以下を自動で行います：
- `.env` ファイルの作成
- `GoogleService-Info.plist` から URL スキームを読み取り
- `project.yml` を生成
- Xcode プロジェクトを生成

### 4. 環境変数の設定

```bash
# .env を編集して FIREBASE_PROJECT_ID を設定
vim .env
```

### 5. ワークスペースを開く

```bash
open AppTemplate.xcworkspace
```

> **Note**: `GoogleService-Info.plist` を変更した場合は `make xcode-generate` で再生成してください。

## 開発

### Firebase Emulator の起動

```bash
make emulator
```

### Swift Server の起動

```bash
make server-run
```

### iOS アプリの実行

Xcode でシミュレータまたは実機で実行、または:

```bash
/ios-dev:ios-run
```

## プロジェクト構造

```
├── iOS/
│   ├── project.yml             # XcodeGen 設定
│   ├── App/                    # iOS アプリ本体
│   │   ├── App.entitlements    # Sign in with Apple
│   │   └── Sources/
│   │       ├── DI/             # DIコンテナ
│   │       ├── AppDelegate.swift
│   │       └── AppTemplateApp.swift
│   └── Packages/
│       ├── Presentation/       # UI層
│       │   └── Sources/
│       │       ├── Stores/     # @Statable 状態管理
│       │       ├── Views/      # SwiftUI ビュー
│       │       ├── Components/ # 再利用可能コンポーネント
│       │       ├── Routing/    # ナビゲーション定義
│       │       └── Theme/      # テーマ設定
│       └── UseCases/           # ビジネスロジック層
│           └── Sources/
│               ├── Protocols/  # UseCase プロトコル
│               ├── Implementations/ # UseCase 実装
│               └── DI/         # Dependencies プロトコル
├── Backend/
│   └── Sources/
│       ├── Server/             # サーバーエントリポイント
│       └── Services/           # バックエンドサービス
│           ├── Configuration/  # 設定
│           ├── Domain/         # リポジトリプロトコル
│           ├── Infrastructure/ # Firestore 実装
│           └── UseCase/        # ユースケース
├── Shared/                     # 共有モデル
│   └── Sources/Shared/
│       ├── Entities/           # ドメインエンティティ
│       ├── API/                # API コントラクト
│       └── Extensions/         # 共通拡張
├── firebase/                   # Firebase 設定
├── AppTemplate.xcworkspace     # Xcode ワークスペース
├── Makefile                    # 開発コマンド
└── CLAUDE.md                   # Claude Code 設定
```

## 使用パッケージ

### no-problem SPM パッケージ

| パッケージ | 用途 |
|-----------|------|
| swift-api-contract | API エンドポイント定義 |
| swift-api-client | HTTP クライアント |
| swift-authentication | Firebase 認証 |
| swift-statable | 状態管理マクロ |
| swift-design-system | UI コンポーネント |
| swift-ui-routing | ナビゲーション |
| swift-api-server | サーバーフレームワーク |
| swift-firebase-server | Firestore クライアント |
| swift-env | 環境変数管理 |

## カスタマイズ

### エンティティの追加

1. `Shared/Sources/Shared/Entities/` に新しいエンティティを追加
2. `Shared/Sources/Shared/API/Contracts/` に API コントラクトを追加
3. `iOS/Packages/UseCases/` に UseCase を追加
4. `iOS/Packages/Presentation/Stores/` に Store を追加
5. `Backend/Sources/Services/` にリポジトリとサービスを追加

### テーマのカスタマイズ

`iOS/Packages/Presentation/Sources/Presentation/Theme/AppTheme.swift` を編集

## ライセンス

MIT
