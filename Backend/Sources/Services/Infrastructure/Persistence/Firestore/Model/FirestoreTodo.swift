import FirestoreSchema
import Foundation
import Shared

@FirestoreModel(keyStrategy: .snakeCase)
public struct FirestoreTodo: Sendable {
    public let id: String
    public let title: String
    public let description: String?
    public let isCompleted: Bool
    public let categoryId: String?
    public let dueDate: Date?
    public let createdAt: Date
    public let updatedAt: Date

    public func toTodo() -> Todo {
        Todo(
            id: id,
            title: title,
            description: description,
            isCompleted: isCompleted,
            categoryId: categoryId,
            dueDate: dueDate,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}

extension FirestoreTodo {
    public static func from(_ todo: Todo) -> FirestoreTodo {
        FirestoreTodo(
            id: todo.id,
            title: todo.title,
            description: todo.description,
            isCompleted: todo.isCompleted,
            categoryId: todo.categoryId,
            dueDate: todo.dueDate,
            createdAt: todo.createdAt,
            updatedAt: todo.updatedAt
        )
    }
}
