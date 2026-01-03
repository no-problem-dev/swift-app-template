import APIClient
import Foundation
import Shared

public struct ProfileUseCaseImpl<Executor: APIExecutable>: ProfileUseCase, Sendable {
    private let executor: Executor

    public init(executor: Executor) {
        self.executor = executor
    }

    public func getProfile() async throws -> UserProfile {
        try await ProfileAPI.Get().execute(using: executor)
    }

    public func updateProfile(input: UpdateProfileInput) async throws -> UserProfile {
        try await ProfileAPI.Update(input: input).execute(using: executor)
    }
}

struct PlaceholderProfileUseCase: ProfileUseCase {
    func getProfile() async throws -> UserProfile { fatalError() }
    func updateProfile(input: UpdateProfileInput) async throws -> UserProfile { fatalError() }
}
