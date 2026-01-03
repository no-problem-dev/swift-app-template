import Shared
import SwiftUI
import UseCases

/// Sheet for creating or editing a category
struct CategoryEditSheet: View {
    enum Mode {
        case create
        case edit(TodoCategory)

        var title: String {
            switch self {
            case .create: "New Category"
            case .edit: "Edit Category"
            }
        }
    }

    let mode: Mode

    @Environment(\.dependencies) private var dependencies
    @Environment(\.categoryStore) private var categoryStore
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var selectedColor: String = TodoCategory.availableColors[0]
    @State private var isSaving = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                }

                Section("Color") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
                        ForEach(TodoCategory.availableColors, id: \.self) { color in
                            Circle()
                                .fill(Color(hex: color))
                                .frame(width: 44, height: 44)
                                .overlay {
                                    if color == selectedColor {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.white)
                                            .fontWeight(.bold)
                                    }
                                }
                                .onTapGesture {
                                    selectedColor = color
                                }
                        }
                    }
                    .padding(.vertical, 8)
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
                    .disabled(name.isEmpty || isSaving)
                }
            }
            .onAppear {
                if case .edit(let category) = mode {
                    name = category.name
                    selectedColor = category.color
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
                let input = CreateCategoryInput(name: name, color: selectedColor)
                let category = try await dependencies.useCases.category.createCategory(input: input)
                categoryStore.addCategory(category)

            case .edit(let existing):
                let input = UpdateCategoryInput(name: name, color: selectedColor)
                let category = try await dependencies.useCases.category.updateCategory(
                    id: existing.id,
                    input: input
                )
                categoryStore.updateCategory(category)
            }
            dismiss()
        } catch {
            print("Failed to save category: \(error)")
        }
        isSaving = false
    }
}
