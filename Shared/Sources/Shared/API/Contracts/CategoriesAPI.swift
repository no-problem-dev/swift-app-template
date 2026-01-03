import APIContract
import Foundation

/// API endpoints for TodoCategory operations
@APIGroup(path: "/v1/categories", auth: .required)
public enum CategoriesAPI {
    /// List all categories
    @Endpoint(.get)
    public struct List {
        public typealias Output = [TodoCategory]
    }

    /// Get a single category by ID
    @Endpoint(.get, path: ":categoryId")
    public struct Get {
        @PathParam public var categoryId: String

        public typealias Output = TodoCategory
    }

    /// Create a new category
    @Endpoint(.post)
    public struct Create {
        @Body public var input: CreateCategoryInput

        public typealias Output = TodoCategory
    }

    /// Update an existing category
    @Endpoint(.patch, path: ":categoryId")
    public struct Update {
        @PathParam public var categoryId: String
        @Body public var input: UpdateCategoryInput

        public typealias Output = TodoCategory
    }

    /// Delete a category
    @Endpoint(.delete, path: ":categoryId")
    public struct Delete {
        @PathParam public var categoryId: String

        public typealias Output = EmptyResponse
    }
}
