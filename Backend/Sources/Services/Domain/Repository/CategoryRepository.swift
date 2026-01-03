import Shared

public protocol CategoryRepository: Sendable {
    func getAll(userId: String) async throws -> [TodoCategory]
    func get(userId: String, categoryId: String) async throws -> TodoCategory?
    func create(userId: String, input: CreateCategoryInput) async throws -> TodoCategory
    func update(userId: String, categoryId: String, input: UpdateCategoryInput) async throws -> TodoCategory
    func delete(userId: String, categoryId: String) async throws
}
