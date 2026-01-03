import APIClient
import Foundation
import Shared

public struct TodoUseCaseImpl<Executor: APIExecutable>: TodoUseCase, Sendable {
    private let executor: Executor

    public init(executor: Executor) {
        self.executor = executor
    }

    public func getTodos(
        categoryId: String?,
        isCompleted: Bool?,
        limit: Int,
        offset: Int
    ) async throws -> [Todo] {
        try await TodosAPI.List(
            categoryId: categoryId,
            isCompleted: isCompleted,
            limit: limit,
            offset: offset
        ).execute(using: executor)
    }

    public func getTodo(id: String) async throws -> Todo {
        try await TodosAPI.Get(todoId: id).execute(using: executor)
    }

    public func createTodo(input: CreateTodoInput) async throws -> Todo {
        try await TodosAPI.Create(input: input).execute(using: executor)
    }

    public func updateTodo(id: String, input: UpdateTodoInput) async throws -> Todo {
        try await TodosAPI.Update(todoId: id, input: input).execute(using: executor)
    }

    public func deleteTodo(id: String) async throws {
        _ = try await TodosAPI.Delete(todoId: id).execute(using: executor)
    }

    public func toggleTodo(id: String) async throws -> Todo {
        try await TodosAPI.Toggle(todoId: id).execute(using: executor)
    }
}

struct PlaceholderTodoUseCase: TodoUseCase {
    func getTodos(categoryId: String?, isCompleted: Bool?, limit: Int, offset: Int) async throws -> [Todo] { fatalError() }
    func getTodo(id: String) async throws -> Todo { fatalError() }
    func createTodo(input: CreateTodoInput) async throws -> Todo { fatalError() }
    func updateTodo(id: String, input: UpdateTodoInput) async throws -> Todo { fatalError() }
    func deleteTodo(id: String) async throws { fatalError() }
    func toggleTodo(id: String) async throws -> Todo { fatalError() }
}
