import APIServer
import BackendServices
import Shared

struct TodosService: TodosAPIService {
    private let todoUseCase: TodoUseCase

    init(todoUseCase: TodoUseCase) {
        self.todoUseCase = todoUseCase
    }

    func handle(_ input: TodosAPI.List, context: ServiceContext) async throws -> [Todo] {
        let userId = try context.requireUserId()
        return try await todoUseCase.getTodos(userId: userId)
    }

    func handle(_ input: TodosAPI.Get, context: ServiceContext) async throws -> Todo {
        let userId = try context.requireUserId()
        guard let todo = try await todoUseCase.getTodo(userId: userId, todoId: input.todoId) else {
            throw TodosAPIError.notFound(todoId: input.todoId)
        }
        return todo
    }

    func handle(_ input: TodosAPI.Create, context: ServiceContext) async throws -> Todo {
        let userId = try context.requireUserId()
        return try await todoUseCase.createTodo(userId: userId, input: input.input)
    }

    func handle(_ input: TodosAPI.Update, context: ServiceContext) async throws -> Todo {
        let userId = try context.requireUserId()
        return try await todoUseCase.updateTodo(userId: userId, todoId: input.todoId, input: input.input)
    }

    func handle(_ input: TodosAPI.Toggle, context: ServiceContext) async throws -> Todo {
        let userId = try context.requireUserId()
        return try await todoUseCase.toggleTodo(userId: userId, todoId: input.todoId)
    }

    func handle(_ input: TodosAPI.Delete, context: ServiceContext) async throws -> EmptyResponse {
        let userId = try context.requireUserId()
        try await todoUseCase.deleteTodo(userId: userId, todoId: input.todoId)
        return EmptyResponse()
    }
}
