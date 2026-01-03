import Foundation
import Shared

public struct CategoryUseCase: Sendable {
    private let categoryRepository: CategoryRepository

    public init(categoryRepository: CategoryRepository) {
        self.categoryRepository = categoryRepository
    }

    public func getCategories(userId: String) async throws -> [TodoCategory] {
        try await categoryRepository.getAll(userId: userId)
    }

    public func getCategory(userId: String, categoryId: String) async throws -> TodoCategory? {
        try await categoryRepository.get(userId: userId, categoryId: categoryId)
    }

    public func createCategory(userId: String, input: CreateCategoryInput) async throws -> TodoCategory {
        try await categoryRepository.create(userId: userId, input: input)
    }

    public func updateCategory(userId: String, categoryId: String, input: UpdateCategoryInput) async throws -> TodoCategory {
        try await categoryRepository.update(userId: userId, categoryId: categoryId, input: input)
    }

    public func deleteCategory(userId: String, categoryId: String) async throws {
        try await categoryRepository.delete(userId: userId, categoryId: categoryId)
    }
}
