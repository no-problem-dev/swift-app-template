import APIServer
import Shared

struct AuthService: AuthAPIService {

    func handle(_ input: AuthAPI.Initialize, context: ServiceContext) async throws -> AuthInitializeResponse {
        _ = try context.requireUserId()
        return AuthInitializeResponse(initialized: true, message: "User initialized successfully")
    }
}
