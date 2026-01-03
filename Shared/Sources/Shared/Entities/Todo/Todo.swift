import Foundation

/// Todo item entity - the main domain model
public struct Todo: Codable, Sendable, Identifiable, Hashable {
    public let id: String
    public let title: String
    public let description: String?
    public let isCompleted: Bool
    public let categoryId: String?
    public let dueDate: Date?
    public let createdAt: Date
    public let updatedAt: Date

    public init(
        id: String,
        title: String,
        description: String? = nil,
        isCompleted: Bool = false,
        categoryId: String? = nil,
        dueDate: Date? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.categoryId = categoryId
        self.dueDate = dueDate
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

extension Todo {
    /// Creates a new Todo with updated completion status
    public func toggleCompleted() -> Todo {
        Todo(
            id: id,
            title: title,
            description: description,
            isCompleted: !isCompleted,
            categoryId: categoryId,
            dueDate: dueDate,
            createdAt: createdAt,
            updatedAt: Date()
        )
    }
}
