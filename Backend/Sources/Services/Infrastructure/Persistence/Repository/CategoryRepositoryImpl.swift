import FirestoreSchema
import FirestoreServer
import Foundation
import Shared

public struct CategoryRepositoryImpl: CategoryRepository {
    private let schema: TodoAppSchema

    public init(schema: TodoAppSchema) {
        self.schema = schema
    }

    private func categoriesCollection(userId: String) -> FirestoreCollection<FirestoreCategory> {
        FirestoreCollection(
            collectionId: "categories",
            database: schema.database,
            client: schema.client,
            parentPath: "users/\(userId)"
        )
    }

    public func getAll(userId: String) async throws -> [TodoCategory] {
        let categories = categoriesCollection(userId: userId)
        let result = try await categories.getAll()
        return result.documents.map { $0.toCategory() }
    }

    public func get(userId: String, categoryId: String) async throws -> TodoCategory? {
        let categories = categoriesCollection(userId: userId)
        do {
            let firestoreCategory = try await categories.document(categoryId).get()
            return firestoreCategory.toCategory()
        } catch let error as FirestoreError {
            if case .api(.notFound) = error {
                return nil
            }
            throw error
        }
    }

    public func create(userId: String, input: CreateCategoryInput) async throws -> TodoCategory {
        let categories = categoriesCollection(userId: userId)
        let now = Date()
        let category = TodoCategory(
            id: UUID().uuidString,
            name: input.name,
            color: input.color,
            createdAt: now,
            updatedAt: now
        )
        try await categories.document(category.id).create(data: FirestoreCategory.from(category))
        return category
    }

    public func update(userId: String, categoryId: String, input: UpdateCategoryInput) async throws -> TodoCategory {
        let categories = categoriesCollection(userId: userId)
        guard let existing = try await get(userId: userId, categoryId: categoryId) else {
            throw CategoriesAPIError.notFound(categoryId: categoryId)
        }

        let updated = TodoCategory(
            id: existing.id,
            name: input.name ?? existing.name,
            color: input.color ?? existing.color,
            createdAt: existing.createdAt,
            updatedAt: Date()
        )
        try await categories.document(categoryId).update(data: FirestoreCategory.from(updated))
        return updated
    }

    public func delete(userId: String, categoryId: String) async throws {
        let categories = categoriesCollection(userId: userId)
        try await categories.document(categoryId).delete()
    }
}
