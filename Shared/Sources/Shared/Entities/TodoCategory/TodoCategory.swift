import Foundation

/// TodoCategory entity for grouping Todos
public struct TodoCategory: Codable, Sendable, Identifiable, Hashable {
    public let id: String
    public let name: String
    public let color: String
    public let createdAt: Date
    public let updatedAt: Date

    public init(
        id: String,
        name: String,
        color: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.color = color
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

/// Predefined colors for categories
public extension TodoCategory {
    static let availableColors: [String] = [
        "#FF6B6B", // Red
        "#4ECDC4", // Teal
        "#45B7D1", // Blue
        "#96CEB4", // Green
        "#FFEAA7", // Yellow
        "#DDA0DD", // Plum
        "#98D8C8", // Mint
        "#F7DC6F", // Gold
    ]
}
