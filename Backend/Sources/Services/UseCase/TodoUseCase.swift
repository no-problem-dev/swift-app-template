import Foundation
import Shared

public struct TodoUseCase: Sendable {
    private let todoRepository: TodoRepository

    public init(todoRepository: TodoRepository) {
        self.todoRepository = todoRepository
    }

    public func getTodos(userId: String) async throws -> [Todo] {
        try await todoRepository.getAll(userId: userId)
    }

    public func getTodo(userId: String, todoId: String) async throws -> Todo? {
        try await todoRepository.get(userId: userId, todoId: todoId)
    }

    public func createTodo(userId: String, input: CreateTodoInput) async throws -> Todo {
        try await todoRepository.create(userId: userId, input: input)
    }

    public func updateTodo(userId: String, todoId: String, input: UpdateTodoInput) async throws -> Todo {
        try await todoRepository.update(userId: userId, todoId: todoId, input: input)
    }

    public func toggleTodo(userId: String, todoId: String) async throws -> Todo {
        try await todoRepository.toggle(userId: userId, todoId: todoId)
    }

    public func deleteTodo(userId: String, todoId: String) async throws {
        try await todoRepository.delete(userId: userId, todoId: todoId)
    }
}
