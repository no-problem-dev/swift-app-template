import Foundation

/// Input for creating a new TodoCategory
public struct CreateCategoryInput: Codable, Sendable {
    public let name: String
    public let color: String

    public init(name: String, color: String) {
        self.name = name
        self.color = color
    }
}

/// Input for updating an existing TodoCategory
public struct UpdateCategoryInput: Codable, Sendable {
    public let name: String?
    public let color: String?

    public init(name: String? = nil, color: String? = nil) {
        self.name = name
        self.color = color
    }
}
