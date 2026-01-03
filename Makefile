# 📱 App Template Makefile
# Backend (Swift Server)、Firebase Emulator の操作用
# iOS テスト・ビルド等は Claude Code プラグインで実行

.PHONY: all help setup \
        xcode-generate \
        server-build server-run server-test server-clean server-release-build \
        emulator emulator-stop emulator-status \
        kill-ports env-check clean doctor \
        release-start release-prepare release-status \
        docker-build-server deploy-setup deploy-server

# ========================================
# プロジェクト設定
# ========================================

BACKEND_DIR = Backend
SHARED_DIR = Shared
FIREBASE_DIR = firebase
SERVER_PORT ?= 8080

-include .env

# ========================================
# Firebase/GCP 環境変数
# ========================================

# Emulator ポート設定
EMULATOR_FIRESTORE_PORT ?= 8090
EMULATOR_AUTH_PORT ?= 9099

# Server開発環境（Emulator使用）
SERVER_DEV_ENV = \
	FIREBASE_PROJECT_ID=$(FIREBASE_PROJECT_ID) \
	USE_FIREBASE_EMULATOR=true \
	FIRESTORE_EMULATOR_HOST=localhost:$(EMULATOR_FIRESTORE_PORT) \
	FIREBASE_AUTH_EMULATOR_HOST=localhost:$(EMULATOR_AUTH_PORT) \
	PORT=$(SERVER_PORT)

# デフォルトターゲット
all: help

# ヘルプ表示
help:
	@echo "📱 App Template Development Commands"
	@echo ""
	@echo "🚀 Setup:"
	@echo "  make setup              - Initial project setup (generates Xcode project)"
	@echo "  make xcode-generate     - Regenerate Xcode project from project.yml"
	@echo ""
	@echo "🦅 Server Commands (Swift):"
	@echo "  make server-build       - Build Swift server (debug)"
	@echo "  make server-run         - Run Swift server locally with Emulator"
	@echo "  make server-test        - Run Swift server tests"
	@echo "  make server-clean       - Clean Swift build artifacts"
	@echo "  make server-release-build - Build optimized release binary"
	@echo ""
	@echo "🔥 Firebase Emulator:"
	@echo "  make emulator           - Start Firebase emulators (foreground)"
	@echo "  make emulator-stop      - Stop Firebase emulators"
	@echo "  make emulator-status    - Check emulator status"
	@echo ""
	@echo "🛠️  Utilities:"
	@echo "  make kill-ports         - Kill processes on Firebase/Server ports"
	@echo "  make env-check          - Display current environment variables"
	@echo "  make clean              - Clean all build artifacts"
	@echo "  make doctor             - Check development environment"
	@echo ""
	@echo "📦 Claude Code Plugins:"
	@echo "  /ios-dev:ios-*          - iOS build, test, run commands"
	@echo ""
	@echo "🚀 Release Commands:"
	@echo "  make release-start      - Start development on latest release branch"
	@echo "  make release-prepare    - Validate CHANGELOG for release"
	@echo "  make release-status     - Check current release status"
	@echo ""
	@echo "🐳 Docker Commands:"
	@echo "  make docker-build-server - Build Server Docker image locally"
	@echo ""
	@echo "☁️  Deployment Commands:"
	@echo "  make deploy-setup        - Create Artifact Registry repository"
	@echo "  make deploy-server       - Build and deploy Server to Cloud Run"

# ========================================
# Server Commands (Swift)
# ========================================

# Server デバッグビルド
server-build:
	@echo "🦅 Building Swift server..."
	@cd $(BACKEND_DIR) && swift build --target Server
	@echo "✅ Build complete"

# Server ローカル実行（Emulator使用）
server-run:
	@echo "🦅 Running Swift server on port $(SERVER_PORT)..."
	@cd $(BACKEND_DIR) && \
		$(SERVER_DEV_ENV) \
		swift run Server

# Server テスト実行
server-test:
	@echo "🧪 Running Swift server tests..."
	@cd $(BACKEND_DIR) && swift test

# Server クリーンアップ
server-clean:
	@echo "🧹 Cleaning Swift build artifacts..."
	@cd $(BACKEND_DIR) && swift package clean
	@rm -rf $(BACKEND_DIR)/.build
	@echo "✅ Clean complete"

# Server リリースビルド（最適化）
server-release-build:
	@echo "🚀 Building optimized release binary..."
	@cd $(BACKEND_DIR) && swift build -c release --target Server
	@echo "✅ Release build complete"
	@ls -lh $(BACKEND_DIR)/.build/release/Server

# ========================================
# Shared Package Commands
# ========================================

# Shared パッケージテスト
shared-test:
	@echo "🧪 Running Shared package tests..."
	@cd $(SHARED_DIR) && swift test

# ========================================
# Firebase Emulator Commands
# ========================================

# Firebase エミュレーター起動（フォアグラウンド）
emulator:
	@echo "🔥 Starting Firebase emulators..."
	@cd $(FIREBASE_DIR) && firebase emulators:start --project $(FIREBASE_PROJECT_ID)

# Firebase エミュレーター停止
emulator-stop:
	@echo "🔥 Stopping Firebase emulators..."
	@lsof -ti :$(EMULATOR_FIRESTORE_PORT) | xargs kill -9 2>/dev/null || true
	@lsof -ti :$(EMULATOR_AUTH_PORT) | xargs kill -9 2>/dev/null || true
	@echo "✅ Emulators stopped"

# Firebase エミュレーター状態確認
emulator-status:
	@echo "🔥 Checking emulator status..."
	@echo -n "  Firestore ($(EMULATOR_FIRESTORE_PORT)): "
	@lsof -i :$(EMULATOR_FIRESTORE_PORT) > /dev/null 2>&1 && echo "✅ Running" || echo "❌ Stopped"
	@echo -n "  Auth ($(EMULATOR_AUTH_PORT)): "
	@lsof -i :$(EMULATOR_AUTH_PORT) > /dev/null 2>&1 && echo "✅ Running" || echo "❌ Stopped"

# ポート強制終了（Firebase + Server）
kill-ports:
	@echo "🔪 Killing processes on Firebase/Server ports..."
	@lsof -ti :$(EMULATOR_FIRESTORE_PORT) | xargs kill -9 2>/dev/null || true
	@lsof -ti :$(EMULATOR_AUTH_PORT) | xargs kill -9 2>/dev/null || true
	@lsof -ti :$(SERVER_PORT) | xargs kill -9 2>/dev/null || true
	@echo "✅ Port cleanup complete"

# ========================================
# Xcode Project Generation
# ========================================

# Xcode プロジェクト生成（GoogleService-Info.plistからURLスキームを自動設定）
xcode-generate:
	@./scripts/setup/generate-project.sh

# 初期セットアップ
setup:
	@echo "🚀 Initial Setup"
	@echo ""
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "✅ Created .env from .env.example"; \
	fi
	@if [ ! -f setup.config ]; then \
		cp setup.config.example setup.config; \
		echo "✅ Created setup.config from setup.config.example"; \
		echo ""; \
		echo "📋 Next steps:"; \
		echo "   1. Edit setup.config with your app settings"; \
		echo "   2. Place GoogleService-Info.plist in iOS/App/"; \
		echo "   3. Run: make setup"; \
	elif [ ! -f iOS/App/GoogleService-Info.plist ]; then \
		echo "⚠️  GoogleService-Info.plist not found"; \
		echo ""; \
		echo "📋 Next steps:"; \
		echo "   1. Download GoogleService-Info.plist from Firebase Console"; \
		echo "   2. Place it in iOS/App/GoogleService-Info.plist"; \
		echo "   3. Run: make setup"; \
	else \
		$(MAKE) xcode-generate; \
	fi

# ========================================
# Utilities
# ========================================

# クリーンアップ（Server + Shared）
clean:
	@echo "🧹 Cleaning build artifacts..."
	@echo "  🦅 Cleaning Server..."
	@$(MAKE) server-clean
	@echo "  📦 Cleaning Shared..."
	@cd $(SHARED_DIR) && swift package clean 2>/dev/null || true
	@rm -rf $(SHARED_DIR)/.build 2>/dev/null || true
	@echo "✅ Clean complete"

# 開発環境の健康状態チェック
doctor:
	@echo "🩺 Checking development environment health..."
	@echo ""
	@echo "📋 Swift Tools:"
	@echo -n "  Xcode: "
	@xcodebuild -version 2>/dev/null | head -1 || echo "❌ Not installed"
	@echo -n "  Swift: "
	@swift --version 2>/dev/null | head -1 || echo "❌ Not installed"
	@echo -n "  XcodeGen: "
	@xcodegen --version 2>/dev/null || echo "❌ Not installed (brew install xcodegen)"
	@echo ""
	@echo "☁️  Cloud Tools:"
	@echo -n "  Firebase CLI: "
	@firebase --version 2>/dev/null || echo "❌ Not installed (npm install -g firebase-tools)"
	@echo ""
	@echo "🔥 Firebase Emulator Status:"
	@$(MAKE) emulator-status

# 環境変数の確認
env-check:
	@echo "⚙️  Environment Variables Configuration"
	@echo ""
	@echo "📁 Configuration Source:"
	@if [ -f .env ]; then \
		echo "  ✅ .env file found"; \
		echo ""; \
		echo "🔧 Firebase:"; \
		echo "  FIREBASE_PROJECT_ID      = $(FIREBASE_PROJECT_ID)"; \
		echo ""; \
		echo "🔥 Emulator Settings:"; \
		echo "  FIRESTORE_EMULATOR_HOST  = localhost:$(EMULATOR_FIRESTORE_PORT)"; \
		echo "  FIREBASE_AUTH_EMULATOR_HOST = localhost:$(EMULATOR_AUTH_PORT)"; \
		echo ""; \
		echo "🦅 Server Configuration:"; \
		echo "  SERVER_PORT              = $(SERVER_PORT)"; \
	else \
		echo "  ❌ .env file not found"; \
		echo ""; \
		echo "⚠️  ERROR: .env file is required"; \
		echo "  Copy .env.example to .env and configure"; \
		exit 1; \
	fi

# ========================================
# Release Commands
# ========================================

# 次の開発サイクル開始
release-start:
	@./scripts/git/release-start.sh

# リリース準備（CHANGELOG検証）
release-prepare:
	@./scripts/git/release-prepare.sh

# リリース状況確認
release-status:
	@./scripts/git/release-status.sh

# ========================================
# Docker Commands
# ========================================

DOCKER_REGION ?= asia-northeast1
DOCKER_REPO ?= app-template
DOCKER_TAG ?= latest
GCP_PROJECT_ID ?= $(FIREBASE_PROJECT_ID)

# Server イメージをローカルでビルド
docker-build-server:
	@echo "🐳 Building Server Docker image..."
	docker build \
		-f Backend/Dockerfile.server \
		-t $(DOCKER_REGION)-docker.pkg.dev/$(GCP_PROJECT_ID)/$(DOCKER_REPO)/server:$(DOCKER_TAG) \
		.
	@echo "✅ Server image built"

# ========================================
# Deployment Commands
# ========================================

# Artifact Registry リポジトリ作成
deploy-setup:
	@echo "☁️  Creating Artifact Registry repository..."
	gcloud artifacts repositories create $(DOCKER_REPO) \
		--repository-format=docker \
		--location=$(DOCKER_REGION) \
		--description="App Template Docker images" \
		--project=$(GCP_PROJECT_ID) || true
	@echo "☁️  Configuring Docker authentication..."
	gcloud auth configure-docker $(DOCKER_REGION)-docker.pkg.dev --quiet
	@echo "✅ Artifact Registry setup complete"

# Server をビルド・プッシュ・デプロイ
deploy-server: docker-build-server
	@echo "☁️  Pushing Server image..."
	docker push $(DOCKER_REGION)-docker.pkg.dev/$(GCP_PROJECT_ID)/$(DOCKER_REPO)/server:$(DOCKER_TAG)
	@echo "☁️  Deploying Server to Cloud Run..."
	gcloud run deploy $(DOCKER_REPO)-backend \
		--image $(DOCKER_REGION)-docker.pkg.dev/$(GCP_PROJECT_ID)/$(DOCKER_REPO)/server:$(DOCKER_TAG) \
		--region $(DOCKER_REGION) \
		--platform managed \
		--allow-unauthenticated \
		--port 8080 \
		--memory 512Mi \
		--cpu 1 \
		--min-instances 0 \
		--max-instances 10 \
		--set-env-vars "GCP_PROJECT_ID=$(GCP_PROJECT_ID)" \
		--project $(GCP_PROJECT_ID)
	@echo "✅ Server deployed"
