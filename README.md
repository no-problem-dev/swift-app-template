# Swift App Template

iOS + Swift Backend のフルスタックテンプレート。Clean Architecture、Firebase認証、Firestoreを使用。

## 必要環境

- Xcode 16+
- Swift 6.0+
- XcodeGen (`brew install xcodegen`)
- Firebase CLI (`npm install -g firebase-tools`)

## セットアップ

### 1. テンプレートからリポジトリ作成

GitHub で "Use this template" ボタンをクリック、または:

```bash
gh repo create my-app --template no-problem-dev/swift-app-template --clone
cd my-app
```

### 2. Firebase プロジェクトの設定

1. [Firebase Console](https://console.firebase.google.com/) でプロジェクトを作成
2. iOS アプリを追加
3. `GoogleService-Info.plist` をダウンロードして `iOS/App/` に配置
4. Authentication で Apple / Google サインインを有効化
5. Firestore Database を作成

### 3. プロジェクト生成

```bash
make setup
```

このコマンドで自動実行:
- `.env` ファイル作成
- `GoogleService-Info.plist` から URL スキーム読み取り
- `project.yml` 生成
- Xcode プロジェクト生成

### 4. 環境変数の設定

```bash
# .env を編集して FIREBASE_PROJECT_ID を設定
vim .env
```

### 5. ワークスペースを開く

```bash
open AppTemplate.xcworkspace
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
