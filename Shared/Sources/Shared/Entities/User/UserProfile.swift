import Foundation

/// User profile entity
public struct UserProfile: Codable, Sendable, Identifiable, Hashable {
    public let id: String
    public let displayName: String
    public let email: String?
    public let createdAt: Date
    public let updatedAt: Date

    public init(
        id: String,
        displayName: String,
        email: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.displayName = displayName
        self.email = email
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

/// Input for creating/updating user profile
public struct UpdateProfileInput: Codable, Sendable {
    public let displayName: String

    public init(displayName: String) {
        self.displayName = displayName
    }
}
