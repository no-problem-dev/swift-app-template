import Foundation
import Shared

public struct ProfileUseCase: Sendable {
    private let profileRepository: ProfileRepository

    public init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    public func getProfile(userId: String) async throws -> UserProfile? {
        try await profileRepository.get(userId: userId)
    }

    public func upsertProfile(userId: String, displayName: String, email: String?) async throws -> UserProfile {
        try await profileRepository.upsert(userId: userId, displayName: displayName, email: email)
    }
}
