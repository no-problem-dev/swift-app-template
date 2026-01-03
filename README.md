# Swift App Template

iOS + Swift Backend のフルスタックテンプレート。Clean Architecture、Firebase認証、Firestoreを使用。

## 必要環境

- Xcode 16+
- Swift 6.0+
- XcodeGen (`brew install xcodegen`)
- Firebase CLI (`npm install -g firebase-tools`)

## セットアップ

### 1. テンプレートからリポジトリ作成

```bash
gh repo create my-app --template no-problem-dev/swift-app-template --clone
cd my-app
```

### 2. 設定ファイルの生成

```bash
make setup  # setup.config と .env を生成
```

`setup.config` を編集:
```bash
APP_NAME=MyApp
APP_DISPLAY_NAME="My App"
BUNDLE_ID_PREFIX=com.mycompany
BUNDLE_ID=com.mycompany.myapp
DEVELOPMENT_TEAM=XXXXXXXXXX
```

`.env` を編集:
```bash
FIREBASE_PROJECT_ID=your-project-id
```

### 3. Firebase 設定

1. [Firebase Console](https://console.firebase.google.com/) でプロジェクト作成
2. iOS アプリを追加（Bundle ID は setup.config の BUNDLE_ID と一致させる）
3. `GoogleService-Info.plist` を `iOS/App/` に配置

### 4. プロジェクト生成

```bash
make setup
open MyApp.xcworkspace  # APP_NAMEで指定した名前
```

## 開発

### Firebase Emulator

```bash
make emulator        # 起動
make emulator-status # 状態確認
make emulator-stop   # 停止
```

### Swift Server

```bash
make server-run   # 起動（Emulator使用）
make server-build # ビルド
make server-test  # テスト
```

### iOS アプリ

Xcode でシミュレータまたは実機で実行。

## プロジェクト構造

```
├── iOS/
│   ├── App/                    # iOS アプリ
│   └── Packages/
│       ├── Presentation/       # UI層
│       └── UseCases/           # ビジネスロジック層
├── Backend/
│   └── Sources/
│       ├── Server/             # サーバーエントリポイント
│       └── Services/           # バックエンドサービス
├── Shared/                     # 共有モデル・API定義
├── firebase/                   # Firebase設定
└── Makefile                    # 開発コマンド
```

## カスタマイズ

### エンティティの追加

1. `Shared/Sources/Shared/Entities/` - エンティティ
2. `Shared/Sources/Shared/API/Contracts/` - API コントラクト
3. `iOS/Packages/UseCases/` - UseCase
4. `iOS/Packages/Presentation/Stores/` - Store
5. `Backend/Sources/Services/` - リポジトリ・サービス

## ライセンス

MIT
