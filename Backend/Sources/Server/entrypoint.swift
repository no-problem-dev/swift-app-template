import APIServer
import FirebaseAuthServer

@main
struct Entrypoint {
    static func main() async throws {
        let server = try await Server.create()
        defer { Task { try? await server.shutdown() } }

        let deps = try await Dependencies.resolve(logger: server.logger)

        server.use(CORSServerMiddleware(configuration: .default()))
        server.useErrorMiddleware()
        server.useAuth(FirebaseAuthProvider(authClient: deps.authClient))

        server.get("health") { "OK" }
        server.get("v1", "status") {
            ["status": "running", "version": "0.1.0", "framework": "Vapor (Swift)"]
        }

        deps.services.registerAll(server.routes)

        server.logger.info("Routes registered")
        try await server.run()
    }
}
