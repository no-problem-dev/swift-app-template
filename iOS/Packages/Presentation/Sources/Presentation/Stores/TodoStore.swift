import Shared
import Statable
import SwiftUI

/// Todo状態管理
@Statable([Todo].self)
@MainActor @Observable
public final class TodoStore {

    // MARK: - Initializer

    nonisolated public init() {}

    // MARK: - Computed Properties

    /// 全てのTodo
    public var todos: [Todo] {
        value ?? []
    }

    /// 未完了のTodo
    public var incompleteTodos: [Todo] {
        todos.filter { !$0.isCompleted }
    }

    /// 完了済みのTodo
    public var completedTodos: [Todo] {
        todos.filter { $0.isCompleted }
    }

    /// Todoの総数
    public var totalCount: Int {
        todos.count
    }

    /// 未完了Todoの数
    public var incompleteCount: Int {
        incompleteTodos.count
    }

    /// カテゴリでフィルタしたTodo
    public func todosByCategory(_ categoryId: String?) -> [Todo] {
        guard let categoryId else { return todos.filter { $0.categoryId == nil } }
        return todos.filter { $0.categoryId == categoryId }
    }

    // MARK: - Mutations

    /// Todoリストを設定
    public func setTodos(_ todos: [Todo]) {
        set(todos)
    }

    /// Todoを追加
    public func addTodo(_ todo: Todo) {
        var current = todos
        current.insert(todo, at: 0)
        set(current)
    }

    /// Todoを更新
    public func updateTodo(_ todo: Todo) {
        var current = todos
        if let index = current.firstIndex(where: { $0.id == todo.id }) {
            current[index] = todo
            set(current)
        }
    }

    /// Todoを削除
    public func removeTodo(id: String) {
        var current = todos
        current.removeAll { $0.id == id }
        set(current)
    }
}

// MARK: - Environment

extension EnvironmentValues {
    @Entry public var todoStore: TodoStore = .init()
}
