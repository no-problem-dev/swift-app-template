import Env

// MARK: - AppConfig

/// アプリケーション設定のファサード
///
/// 全ての設定を一箇所で読み込み、各コンポーネントに提供する。
///
/// ## Usage
/// ```swift
/// let appConfig = AppConfig.load()
/// print(appConfig.gcp.projectId)
/// print(appConfig.emulator.firestoreHost)
/// ```
@EnvGroup
public struct AppConfig {
    /// GCP/Firebase プロジェクト設定
    public let gcp: GCPConfig

    /// Firebase Emulator 接続設定
    public let emulator: EmulatorConfig

    /// サーバー設定
    public let server: ServerConfig
}

// MARK: - GCPConfig

/// GCP/Firebase プロジェクト設定
@Env
public struct GCPConfig {
    /// GCPプロジェクトID (`GCP_PROJECT_ID`)
    @Value("gcp.project.id", default: "your-project-id")
    public var projectId: String

    /// Firebase Emulator使用フラグ (`FIREBASE_EMULATOR`)
    @Value("firebase.emulator", default: false)
    public var useEmulator: Bool
}

// MARK: - EmulatorConfig

/// Firebase Emulator 接続設定
@Env(scope: "emulator")
public struct EmulatorConfig {
    /// Firestore Emulator ホスト (`EMULATOR_FIRESTORE_HOST`)
    @Value("firestore.host", default: "localhost")
    public var firestoreHost: String

    /// Firestore Emulator ポート (`EMULATOR_FIRESTORE_PORT`)
    @Value("firestore.port", default: 8090)
    public var firestorePort: Int

    /// Auth Emulator ホスト (`EMULATOR_AUTH_HOST`)
    @Value("auth.host", default: "localhost")
    public var authHost: String

    /// Auth Emulator ポート (`EMULATOR_AUTH_PORT`)
    @Value("auth.port", default: 9099)
    public var authPort: Int
}

// MARK: - ServerConfig

/// サーバー設定
@Env(scope: "server")
public struct ServerConfig {
    /// サーバーポート (`SERVER_PORT`)
    @Value("port", default: 8080)
    public var port: Int
}
