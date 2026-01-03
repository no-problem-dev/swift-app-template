import APIServer
import BackendServices
import Shared

struct ProfileAPIServiceImpl: ProfileAPIService {
    private let profileUseCase: ProfileUseCase

    init(profileUseCase: ProfileUseCase) {
        self.profileUseCase = profileUseCase
    }

    func handle(_ input: ProfileAPI.Get, context: ServiceContext) async throws -> UserProfile {
        let userId = try context.requireUserId()

        guard let profile = try await profileUseCase.getProfile(userId: userId) else {
            throw ProfileAPIError.notFound
        }

        return profile
    }

    func handle(_ input: ProfileAPI.Update, context: ServiceContext) async throws -> UserProfile {
        let userId = try context.requireUserId()

        return try await profileUseCase.upsertProfile(
            userId: userId,
            displayName: input.input.displayName,
            email: nil
        )
    }
}
