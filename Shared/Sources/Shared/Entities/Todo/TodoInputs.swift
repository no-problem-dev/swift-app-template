import Foundation

/// Input for creating a new Todo
public struct CreateTodoInput: Codable, Sendable {
    public let title: String
    public let description: String?
    public let categoryId: String?
    public let dueDate: Date?

    public init(
        title: String,
        description: String? = nil,
        categoryId: String? = nil,
        dueDate: Date? = nil
    ) {
        self.title = title
        self.description = description
        self.categoryId = categoryId
        self.dueDate = dueDate
    }
}

/// Input for updating an existing Todo
public struct UpdateTodoInput: Codable, Sendable {
    public let title: String?
    public let description: String?
    public let isCompleted: Bool?
    public let categoryId: String?
    public let dueDate: Date?

    public init(
        title: String? = nil,
        description: String? = nil,
        isCompleted: Bool? = nil,
        categoryId: String? = nil,
        dueDate: Date? = nil
    ) {
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.categoryId = categoryId
        self.dueDate = dueDate
    }
}
