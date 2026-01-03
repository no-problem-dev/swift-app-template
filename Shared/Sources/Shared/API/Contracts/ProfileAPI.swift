import APIContract
import Foundation

/// API endpoints for User Profile operations
@APIGroup(path: "/v1/profile", auth: .required)
public enum ProfileAPI {
    /// Get current user's profile
    @Endpoint(.get)
    public struct Get {
        public typealias Output = UserProfile
    }

    /// Update current user's profile
    @Endpoint(.patch)
    public struct Update {
        @Body public var input: UpdateProfileInput

        public typealias Output = UserProfile
    }
}
