import SwiftUI
import UIRouting

enum AppSheet: @MainActor Sheetable {
    case createTodo
    case editTodo(todoId: String)
    case createCategory
    case editCategory(categoryId: String)
    case editProfile

    @ViewBuilder
    var body: some View {
        switch self {
        case .createTodo:
            Text("Create Todo (TODO)")
        case .editTodo:
            Text("Edit Todo (TODO)")
        case .createCategory:
            Text("Create Category (TODO)")
        case .editCategory:
            Text("Edit Category (TODO)")
        case .editProfile:
            Text("Edit Profile (TODO)")
        }
    }
}
