import Shared

public protocol TodoRepository: Sendable {
    func getAll(userId: String) async throws -> [Todo]
    func get(userId: String, todoId: String) async throws -> Todo?
    func create(userId: String, input: CreateTodoInput) async throws -> Todo
    func update(userId: String, todoId: String, input: UpdateTodoInput) async throws -> Todo
    func toggle(userId: String, todoId: String) async throws -> Todo
    func delete(userId: String, todoId: String) async throws
}
