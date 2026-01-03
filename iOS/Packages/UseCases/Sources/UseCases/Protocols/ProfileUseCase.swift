import Foundation
import Shared

/// Use case protocol for Profile operations
public protocol ProfileUseCase: Sendable {
    /// Fetch current user's profile
    func getProfile() async throws -> UserProfile

    /// Update current user's profile
    func updateProfile(input: UpdateProfileInput) async throws -> UserProfile
}
