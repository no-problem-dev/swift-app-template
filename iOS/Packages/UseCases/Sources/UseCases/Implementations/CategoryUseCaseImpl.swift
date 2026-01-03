import APIClient
import Foundation
import Shared

public struct CategoryUseCaseImpl<Executor: APIExecutable>: CategoryUseCase, Sendable {
    private let executor: Executor

    public init(executor: Executor) {
        self.executor = executor
    }

    public func getCategories() async throws -> [TodoCategory] {
        try await CategoriesAPI.List().execute(using: executor)
    }

    public func getCategory(id: String) async throws -> TodoCategory {
        try await CategoriesAPI.Get(categoryId: id).execute(using: executor)
    }

    public func createCategory(input: CreateCategoryInput) async throws -> TodoCategory {
        try await CategoriesAPI.Create(input: input).execute(using: executor)
    }

    public func updateCategory(id: String, input: UpdateCategoryInput) async throws -> TodoCategory {
        try await CategoriesAPI.Update(categoryId: id, input: input).execute(using: executor)
    }

    public func deleteCategory(id: String) async throws {
        _ = try await CategoriesAPI.Delete(categoryId: id).execute(using: executor)
    }
}

struct PlaceholderCategoryUseCase: CategoryUseCase {
    func getCategories() async throws -> [TodoCategory] { fatalError() }
    func getCategory(id: String) async throws -> TodoCategory { fatalError() }
    func createCategory(input: CreateCategoryInput) async throws -> TodoCategory { fatalError() }
    func updateCategory(id: String, input: UpdateCategoryInput) async throws -> TodoCategory { fatalError() }
    func deleteCategory(id: String) async throws { fatalError() }
}
