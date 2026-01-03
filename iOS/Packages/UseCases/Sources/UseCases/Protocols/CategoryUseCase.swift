import Foundation
import Shared

/// Use case protocol for TodoCategory operations
public protocol CategoryUseCase: Sendable {
    /// Fetch all categories
    func getCategories() async throws -> [TodoCategory]

    /// Fetch a single category by ID
    func getCategory(id: String) async throws -> TodoCategory

    /// Create a new category
    func createCategory(input: CreateCategoryInput) async throws -> TodoCategory

    /// Update an existing category
    func updateCategory(id: String, input: UpdateCategoryInput) async throws -> TodoCategory

    /// Delete a category
    func deleteCategory(id: String) async throws
}
