import APIContract
import FirebaseAuthServer

public struct FirebaseAuthProvider: AuthenticationProvider {
    private let authClient: AuthClient

    public init(authClient: AuthClient) {
        self.authClient = authClient
    }

    public func verifyToken(_ token: String) async throws -> String {
        do {
            let verifiedToken = try await authClient.verifyAuthorizationHeader("Bearer \(token)")
            return verifiedToken.uid
        } catch let error as AuthError {
            throw AuthenticationError.invalidToken(error.description)
        } catch {
            throw AuthenticationError.authenticationFailed(error.localizedDescription)
        }
    }
}
