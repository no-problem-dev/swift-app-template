import Env
import FirestoreServer

/// Firestore クライアント生成ファクトリ
///
/// ## Usage
/// ```swift
/// let appConfig = AppConfig.load()
/// let client = try await FirestoreClientFactory.create(config: appConfig)
/// ```
public enum FirestoreClientFactory {

    /// AppConfigからFirestoreClientを生成
    ///
    /// - Parameter config: アプリケーション設定
    /// - Returns: FirestoreClient
    public static func create(config: AppConfig) async throws -> FirestoreClient {
        if config.gcp.useEmulator {
            return FirestoreClient(
                .emulator(projectId: config.gcp.projectId),
                keyEncodingStrategy: .convertToSnakeCase,
                keyDecodingStrategy: .convertFromSnakeCase,
                emulatorHost: config.emulator.firestoreHost,
                emulatorPort: config.emulator.firestorePort
            )
        }

        return try await FirestoreClient(
            .auto,
            keyEncodingStrategy: .convertToSnakeCase,
            keyDecodingStrategy: .convertFromSnakeCase
        )
    }
}
