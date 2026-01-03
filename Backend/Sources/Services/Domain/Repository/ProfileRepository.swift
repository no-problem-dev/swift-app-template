import Shared

public protocol ProfileRepository: Sendable {
    func get(userId: String) async throws -> UserProfile?
    func upsert(userId: String, displayName: String, email: String?) async throws -> UserProfile
}
