import FirestoreSchema
import Foundation
import Shared

@FirestoreModel(keyStrategy: .snakeCase)
public struct FirestoreCategory: Sendable {
    public let id: String
    public let name: String
    public let color: String
    public let createdAt: Date
    public let updatedAt: Date

    public func toCategory() -> TodoCategory {
        TodoCategory(
            id: id,
            name: name,
            color: color,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}

extension FirestoreCategory {
    public static func from(_ category: TodoCategory) -> FirestoreCategory {
        FirestoreCategory(
            id: category.id,
            name: category.name,
            color: category.color,
            createdAt: category.createdAt,
            updatedAt: category.updatedAt
        )
    }
}
