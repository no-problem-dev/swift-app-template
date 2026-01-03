import APIContract
import Foundation

/// API endpoints for Todo operations
@APIGroup(path: "/v1/todos", auth: .required)
public enum TodosAPI {
    public static let defaultLimit = 20
    public static let defaultOffset = 0
    public static let maxLimit = 100

    /// List all todos with optional filtering
    @Endpoint(.get)
    public struct List {
        @QueryParam public var categoryId: String?
        @QueryParam public var isCompleted: Bool?
        @QueryParam public var limit: Int? = TodosAPI.defaultLimit
        @QueryParam public var offset: Int? = TodosAPI.defaultOffset

        public typealias Output = [Todo]
    }

    /// Get a single todo by ID
    @Endpoint(.get, path: ":todoId")
    public struct Get {
        @PathParam public var todoId: String

        public typealias Output = Todo
    }

    /// Create a new todo
    @Endpoint(.post)
    public struct Create {
        @Body public var input: CreateTodoInput

        public typealias Output = Todo
    }

    /// Update an existing todo
    @Endpoint(.patch, path: ":todoId")
    public struct Update {
        @PathParam public var todoId: String
        @Body public var input: UpdateTodoInput

        public typealias Output = Todo
    }

    /// Delete a todo
    @Endpoint(.delete, path: ":todoId")
    public struct Delete {
        @PathParam public var todoId: String

        public typealias Output = EmptyResponse
    }

    /// Toggle todo completion status
    @Endpoint(.post, path: ":todoId/toggle")
    public struct Toggle {
        @PathParam public var todoId: String

        public typealias Output = Todo
    }
}
