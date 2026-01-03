import SwiftUI
import UIRouting

enum AppRoute: @MainActor Routable {
    case todoDetail(todoId: String)
    case categoryDetail(categoryId: String)
    case settings

    @ViewBuilder
    var body: some View {
        switch self {
        case .todoDetail:
            Text("Todo Detail (TODO)")
        case .categoryDetail:
            Text("Category Detail (TODO)")
        case .settings:
            Text("Settings (TODO)")
        }
    }
}
