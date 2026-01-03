import APIContract
import Foundation

/// API endpoints for Authentication
@APIGroup(path: "/v1/auth", auth: .required)
public enum AuthAPI {
    /// Initialize user session (called after sign-in)
    @Endpoint(.post, path: "initialize")
    public struct Initialize {
        public typealias Output = AuthInitializeResponse
    }
}

/// Response for auth initialization
public struct AuthInitializeResponse: Codable, Sendable {
    public let initialized: Bool
    public let message: String

    public init(initialized: Bool, message: String) {
        self.initialized = initialized
        self.message = message
    }
}

/// Empty response for delete operations
public struct EmptyResponse: Codable, Sendable {
    public init() {}
}
