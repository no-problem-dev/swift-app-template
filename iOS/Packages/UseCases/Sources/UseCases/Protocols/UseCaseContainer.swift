import Authentication

/// Container protocol that provides access to all use cases
public protocol UseCaseContainer: Sendable {
    associatedtype TodoUseCaseType: TodoUseCase
    associatedtype CategoryUseCaseType: CategoryUseCase
    associatedtype ProfileUseCaseType: ProfileUseCase
    associatedtype AuthUseCaseType: AuthenticationUseCase

    var todo: TodoUseCaseType { get }
    var category: CategoryUseCaseType { get }
    var profile: ProfileUseCaseType { get }
    var auth: AuthUseCaseType { get }
}
