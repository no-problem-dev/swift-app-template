import Shared
import SwiftUI
import UseCases

/// Sheet for creating or editing a todo
struct TodoEditSheet: View {
    enum Mode {
        case create
        case edit(Todo)

        var title: String {
            switch self {
            case .create: "New Todo"
            case .edit: "Edit Todo"
            }
        }
    }

    let mode: Mode

    @Environment(\.dependencies) private var dependencies
    @Environment(\.todoStore) private var todoStore
    @Environment(\.categoryStore) private var categoryStore
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedCategoryId: String?
    @State private var dueDate: Date?
    @State private var hasDueDate = false
    @State private var isSaving = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section {
                    Picker("Category", selection: $selectedCategoryId) {
                        Text("None").tag(nil as String?)
                        ForEach(categoryStore.categories) { category in
                            Text(category.name).tag(category.id as String?)
                        }
                    }
                }

                Section {
                    Toggle("Due Date", isOn: $hasDueDate)
                    if hasDueDate {
                        DatePicker(
                            "Date",
                            selection: Binding(
                                get: { dueDate ?? Date() },
                                set: { dueDate = $0 }
                            ),
                            displayedComponents: [.date]
                        )
                    }
                }
            }
            .navigationTitle(mode.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task { await save() }
                    }
                    .disabled(title.isEmpty || isSaving)
                }
            }
            .onAppear {
                if case .edit(let todo) = mode {
                    title = todo.title
                    description = todo.description ?? ""
                    selectedCategoryId = todo.categoryId
                    dueDate = todo.dueDate
                    hasDueDate = todo.dueDate != nil
                }
            }
            .disabled(isSaving)
        }
    }

    private func save() async {
        isSaving = true
        do {
            switch mode {
            case .create:
                let input = CreateTodoInput(
                    title: title,
                    description: description.isEmpty ? nil : description,
                    categoryId: selectedCategoryId,
                    dueDate: hasDueDate ? dueDate : nil
                )
                let todo = try await dependencies.useCases.todo.createTodo(input: input)
                todoStore.addTodo(todo)

            case .edit(let existing):
                let input = UpdateTodoInput(
                    title: title,
                    description: description.isEmpty ? nil : description,
                    categoryId: selectedCategoryId,
                    dueDate: hasDueDate ? dueDate : nil
                )
                let todo = try await dependencies.useCases.todo.updateTodo(id: existing.id, input: input)
                todoStore.updateTodo(todo)
            }
            dismiss()
        } catch {
            print("Failed to save todo: \(error)")
        }
        isSaving = false
    }
}
