import APIClient
import Authentication
import AuthenticationServices
import Foundation
import Shared
import SwiftUI

public protocol Dependencies: Sendable {
    associatedtype UseCases: UseCaseContainer

    var useCases: UseCases { get }
    var httpEvents: AsyncStream<HTTPEvent> { get }
    var httpLogs: AsyncStream<HTTPLog> { get }
}

extension EnvironmentValues {
    @Entry public var dependencies: any Dependencies = PlaceholderDependencies()
}

public struct UseCaseContainerImpl<Executor: APIExecutable, Auth: AuthenticationUseCase>: UseCaseContainer, Sendable {
    public let todo: TodoUseCaseImpl<Executor>
    public let category: CategoryUseCaseImpl<Executor>
    public let profile: ProfileUseCaseImpl<Executor>
    public let auth: Auth

    public init(executor: Executor, auth: Auth) {
        self.todo = TodoUseCaseImpl(executor: executor)
        self.category = CategoryUseCaseImpl(executor: executor)
        self.profile = ProfileUseCaseImpl(executor: executor)
        self.auth = auth
    }
}

// MARK: - Placeholders

private struct PlaceholderDependencies: Dependencies {
    var useCases: PlaceholderUseCaseContainer { fatalError("Dependencies not configured") }
    var httpEvents: AsyncStream<HTTPEvent> { fatalError("Dependencies not configured") }
    var httpLogs: AsyncStream<HTTPLog> { fatalError("Dependencies not configured") }
}

private struct PlaceholderUseCaseContainer: UseCaseContainer {
    var todo: PlaceholderTodoUseCase { fatalError() }
    var category: PlaceholderCategoryUseCase { fatalError() }
    var profile: PlaceholderProfileUseCase { fatalError() }
    var auth: PlaceholderAuthUseCase { fatalError() }
}

struct PlaceholderAuthUseCase: AuthenticationUseCase {
    func isAuthenticated() async -> Bool { fatalError() }
    func signInWithGoogle() async throws { fatalError() }
    func signInWithApple(authorization: ASAuthorization) async throws { fatalError() }
    func signOut() async throws { fatalError() }
    func deleteAccount() async throws { fatalError() }
    func observeAuthState() -> AsyncStream<AuthenticationState> { fatalError() }
    func signOutOnFreshInstall() async { fatalError() }
    static func handleGoogleSignInURL(_ url: URL) -> Bool { fatalError() }
}
