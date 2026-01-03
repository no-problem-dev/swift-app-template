import Foundation
import Shared

/// Use case protocol for Todo operations
public protocol TodoUseCase: Sendable {
    /// Fetch all todos with optional filtering
    func getTodos(
        categoryId: String?,
        isCompleted: Bool?,
        limit: Int,
        offset: Int
    ) async throws -> [Todo]

    /// Fetch a single todo by ID
    func getTodo(id: String) async throws -> Todo

    /// Create a new todo
    func createTodo(input: CreateTodoInput) async throws -> Todo

    /// Update an existing todo
    func updateTodo(id: String, input: UpdateTodoInput) async throws -> Todo

    /// Delete a todo
    func deleteTodo(id: String) async throws

    /// Toggle todo completion status
    func toggleTodo(id: String) async throws -> Todo
}
