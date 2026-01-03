import Shared
import Statable
import SwiftUI

/// カテゴリ状態管理
@Statable([TodoCategory].self)
@MainActor @Observable
public final class CategoryStore {

    // MARK: - Initializer

    nonisolated public init() {}

    // MARK: - Computed Properties

    /// 全てのカテゴリ
    public var categories: [TodoCategory] {
        value ?? []
    }

    /// カテゴリの総数
    public var totalCount: Int {
        categories.count
    }

    /// カテゴリが存在するか
    public var hasCategories: Bool {
        !categories.isEmpty
    }

    /// 指定IDのカテゴリを取得
    public func category(for id: String?) -> TodoCategory? {
        guard let id else { return nil }
        return categories.first { $0.id == id }
    }

    // MARK: - Mutations

    /// カテゴリリストを設定
    public func setCategories(_ categories: [TodoCategory]) {
        set(categories)
    }

    /// カテゴリを追加
    public func addCategory(_ category: TodoCategory) {
        var current = categories
        current.append(category)
        set(current)
    }

    /// カテゴリを更新
    public func updateCategory(_ category: TodoCategory) {
        var current = categories
        if let index = current.firstIndex(where: { $0.id == category.id }) {
            current[index] = category
            set(current)
        }
    }

    /// カテゴリを削除
    public func removeCategory(id: String) {
        var current = categories
        current.removeAll { $0.id == id }
        set(current)
    }
}

// MARK: - Environment

extension EnvironmentValues {
    @Entry public var categoryStore: CategoryStore = .init()
}
