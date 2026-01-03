import Shared
import SwiftUI
import UseCases

/// View showing all categories
struct CategoryListView: View {
    @Environment(\.dependencies) private var dependencies
    @Environment(\.categoryStore) private var categoryStore
    @State private var showCreateSheet = false
    @State private var isLoading = false

    var body: some View {
        List {
            ForEach(categoryStore.categories) { category in
                CategoryRowView(category: category)
            }

            if categoryStore.categories.isEmpty && !isLoading {
                ContentUnavailableView(
                    "No Categories",
                    systemImage: "folder",
                    description: Text("Tap + to create your first category")
                )
            }
        }
        .navigationTitle("Categories")
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
            await loadCategories()
        }
        .sheet(isPresented: $showCreateSheet) {
            CategoryEditSheet(mode: .create)
        }
        .task {
            await loadCategories()
        }
    }

    private func loadCategories() async {
        isLoading = true
        do {
            let categories = try await dependencies.useCases.category.getCategories()
            categoryStore.setCategories(categories)
        } catch {
            print("Failed to load categories: \(error)")
        }
        isLoading = false
    }
}

struct CategoryRowView: View {
    let category: TodoCategory

    @Environment(\.dependencies) private var dependencies
    @Environment(\.categoryStore) private var categoryStore
    @State private var showEditSheet = false

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color(hex: category.color))
                .frame(width: 24, height: 24)

            Text(category.name)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showEditSheet = true
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                Task { await deleteCategory() }
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .sheet(isPresented: $showEditSheet) {
            CategoryEditSheet(mode: .edit(category))
        }
    }

    private func deleteCategory() async {
        do {
            try await dependencies.useCases.category.deleteCategory(id: category.id)
            categoryStore.removeCategory(id: category.id)
        } catch {
            print("Failed to delete category: \(error)")
        }
    }
}
