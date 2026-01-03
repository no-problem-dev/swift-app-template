import FirestoreSchema
import FirestoreServer
import Foundation
import Shared

public struct ProfileRepositoryImpl: ProfileRepository {
    private let schema: TodoAppSchema

    public init(schema: TodoAppSchema) {
        self.schema = schema
    }

    private var profiles: FirestoreCollection<FirestoreProfile> {
        schema.users
    }

    public func get(userId: String) async throws -> UserProfile? {
        do {
            let firestoreProfile = try await profiles.document(userId).get()
            return firestoreProfile.toUserProfile()
        } catch let error as FirestoreError {
            if case .api(.notFound) = error {
                return nil
            }
            throw error
        }
    }

    public func upsert(userId: String, displayName: String, email: String?) async throws -> UserProfile {
        let now = Date()
        let existing: FirestoreProfile?
        do {
            existing = try await profiles.document(userId).get()
        } catch let error as FirestoreError {
            if case .api(.notFound) = error {
                existing = nil
            } else {
                throw error
            }
        }

        let profile: UserProfile
        if let existingProfile = existing {
            profile = UserProfile(
                id: userId,
                displayName: displayName,
                email: email ?? existingProfile.email,
                createdAt: existingProfile.createdAt,
                updatedAt: now
            )
            try await profiles.document(userId).update(data: FirestoreProfile.from(profile))
        } else {
            profile = UserProfile(
                id: userId,
                displayName: displayName,
                email: email,
                createdAt: now,
                updatedAt: now
            )
            try await profiles.document(userId).create(data: FirestoreProfile.from(profile))
        }

        return profile
    }
}
