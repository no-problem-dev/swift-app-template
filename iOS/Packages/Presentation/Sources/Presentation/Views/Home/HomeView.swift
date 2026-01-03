import Shared
import SwiftUI
import UseCases

/// Home view showing todo list
public struct HomeView: View {
    @Environment(\.dependencies) private var dependencies
    @Environment(\.todoStore) private var todoStore
    @Environment(\.categoryStore) private var categoryStore
    @State private var showCreateSheet = false
    @State private var isLoading = false

    public init() {}

    public var body: some View {
        List {
            if !todoStore.incompleteTodos.isEmpty {
                Section("To Do") {
                    ForEach(todoStore.incompleteTodos) { todo in
                        TodoRowView(todo: todo)
                    }
                }
            }

            if !todoStore.completedTodos.isEmpty {
                Section("Completed") {
                    ForEach(todoStore.completedTodos) { todo in
                        TodoRowView(todo: todo)
                    }
                }
            }

            if todoStore.todos.isEmpty && !isLoading {
                ContentUnavailableView(
                    "No Todos",
                    systemImage: "checklist",
                    description: Text("Tap + to create your first todo")
                )
            }
        }
        .navigationTitle("Home")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showCreateSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .refreshable {
            await loadData()
        }
        .sheet(isPresented: $showCreateSheet) {
            TodoEditSheet(mode: .create)
        }
        .task {
            await loadData()
        }
        .overlay {
            if isLoading && todoStore.todos.isEmpty {
                ProgressView()
            }
        }
    }

    private func loadData() async {
        isLoading = true
        do {
            async let todos = dependencies.useCases.todo.getTodos(
                categoryId: nil,
                isCompleted: nil,
                limit: 100,
                offset: 0
            )
            async let categories = dependencies.useCases.category.getCategories()

            let (fetchedTodos, fetchedCategories) = try await (todos, categories)
            todoStore.setTodos(fetchedTodos)
            categoryStore.setCategories(fetchedCategories)
        } catch {
            print("Failed to load data: \(error)")
        }
        isLoading = false
    }
}
