import FirestoreSchema
import FirestoreServer
import Foundation
import Shared

public struct TodoRepositoryImpl: TodoRepository {
    private let schema: TodoAppSchema

    public init(schema: TodoAppSchema) {
        self.schema = schema
    }

    private func todosCollection(userId: String) -> FirestoreCollection<FirestoreTodo> {
        FirestoreCollection(
            collectionId: "todos",
            database: schema.database,
            client: schema.client,
            parentPath: "users/\(userId)"
        )
    }

    public func getAll(userId: String) async throws -> [Todo] {
        let todos = todosCollection(userId: userId)
        let result = try await todos.getAll()
        return result.documents.map { $0.toTodo() }
    }

    public func get(userId: String, todoId: String) async throws -> Todo? {
        let todos = todosCollection(userId: userId)
        do {
            let firestoreTodo = try await todos.document(todoId).get()
            return firestoreTodo.toTodo()
        } catch let error as FirestoreError {
            if case .api(.notFound) = error {
                return nil
            }
            throw error
        }
    }

    public func create(userId: String, input: CreateTodoInput) async throws -> Todo {
        let todos = todosCollection(userId: userId)
        let now = Date()
        let todo = Todo(
            id: UUID().uuidString,
            title: input.title,
            description: input.description,
            isCompleted: false,
            categoryId: input.categoryId,
            dueDate: input.dueDate,
            createdAt: now,
            updatedAt: now
        )
        try await todos.document(todo.id).create(data: FirestoreTodo.from(todo))
        return todo
    }

    public func update(userId: String, todoId: String, input: UpdateTodoInput) async throws -> Todo {
        let todos = todosCollection(userId: userId)
        guard let existing = try await get(userId: userId, todoId: todoId) else {
            throw TodosAPIError.notFound(todoId: todoId)
        }

        let updated = Todo(
            id: existing.id,
            title: input.title ?? existing.title,
            description: input.description ?? existing.description,
            isCompleted: input.isCompleted ?? existing.isCompleted,
            categoryId: input.categoryId ?? existing.categoryId,
            dueDate: input.dueDate ?? existing.dueDate,
            createdAt: existing.createdAt,
            updatedAt: Date()
        )
        try await todos.document(todoId).update(data: FirestoreTodo.from(updated))
        return updated
    }

    public func toggle(userId: String, todoId: String) async throws -> Todo {
        let todos = todosCollection(userId: userId)
        guard let existing = try await get(userId: userId, todoId: todoId) else {
            throw TodosAPIError.notFound(todoId: todoId)
        }

        let toggled = Todo(
            id: existing.id,
            title: existing.title,
            description: existing.description,
            isCompleted: !existing.isCompleted,
            categoryId: existing.categoryId,
            dueDate: existing.dueDate,
            createdAt: existing.createdAt,
            updatedAt: Date()
        )
        try await todos.document(todoId).update(data: FirestoreTodo.from(toggled))
        return toggled
    }

    public func delete(userId: String, todoId: String) async throws {
        let todos = todosCollection(userId: userId)
        try await todos.document(todoId).delete()
    }
}
