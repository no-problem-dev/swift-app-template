import Shared
import SwiftUI
import UseCases

/// Row view for displaying a single todo item
struct TodoRowView: View {
    let todo: Todo

    @Environment(\.dependencies) private var dependencies
    @Environment(\.todoStore) private var todoStore
    @Environment(\.categoryStore) private var categoryStore
    @State private var showEditSheet = false

    var body: some View {
        HStack(spacing: 12) {
            Button {
                Task { await toggleTodo() }
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(todo.isCompleted ? .green : .secondary)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(todo.title)
                    .strikethrough(todo.isCompleted)
                    .foregroundStyle(todo.isCompleted ? .secondary : .primary)

                HStack(spacing: 8) {
                    if let category = categoryStore.category(for: todo.categoryId) {
                        CategoryBadge(category: category)
                    }

                    if let dueDate = todo.dueDate {
                        Label(dueDate.formatted(style: .short), systemImage: "calendar")
                            .font(.caption)
                            .foregroundStyle(dueDate.isPast && !todo.isCompleted ? .red : .secondary)
                    }
                }
            }

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showEditSheet = true
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                Task { await deleteTodo() }
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .sheet(isPresented: $showEditSheet) {
            TodoEditSheet(mode: .edit(todo))
        }
    }

    private func toggleTodo() async {
        do {
            let updated = try await dependencies.useCases.todo.toggleTodo(id: todo.id)
            todoStore.updateTodo(updated)
        } catch {
            print("Failed to toggle todo: \(error)")
        }
    }

    private func deleteTodo() async {
        do {
            try await dependencies.useCases.todo.deleteTodo(id: todo.id)
            todoStore.removeTodo(id: todo.id)
        } catch {
            print("Failed to delete todo: \(error)")
        }
    }
}
