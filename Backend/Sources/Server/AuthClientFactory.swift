import BackendServices
import FirebaseAuthServer

enum AuthClientFactory {
    static func create(config: AppConfig) -> AuthClient {
        if config.gcp.useEmulator {
            return AuthClient(
                configuration: .emulator(
                    projectId: config.gcp.projectId,
                    host: config.emulator.authHost,
                    port: config.emulator.authPort
                )
            )
        }

        return AuthClient(projectId: config.gcp.projectId)
    }
}
