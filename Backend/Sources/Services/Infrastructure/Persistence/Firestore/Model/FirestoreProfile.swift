import FirestoreSchema
import Foundation
import Shared

@FirestoreModel(keyStrategy: .snakeCase)
public struct FirestoreProfile: Sendable {
    public let id: String
    public let displayName: String
    public let email: String?
    public let createdAt: Date
    public let updatedAt: Date

    public func toUserProfile() -> UserProfile {
        UserProfile(
            id: id,
            displayName: displayName,
            email: email,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}

extension FirestoreProfile {
    public static func from(_ profile: UserProfile) -> FirestoreProfile {
        FirestoreProfile(
            id: profile.id,
            displayName: profile.displayName,
            email: profile.email,
            createdAt: profile.createdAt,
            updatedAt: profile.updatedAt
        )
    }
}
