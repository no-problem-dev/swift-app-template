import SwiftUI
import UIRouting

enum AppTab: @MainActor Tabbable {
    case home
    case categories
    case settings

    typealias Route = AppRoute
    typealias Sheet = AppSheet
    typealias Alert = AppAlert
    typealias FullScreen = Never
    typealias CustomSheet = Never

    @ViewBuilder
    var contentView: some View {
        switch self {
        case .home:
            HomeTabView()
        case .categories:
            CategoriesTabView()
        case .settings:
            SettingsTabView()
        }
    }

    @ViewBuilder
    var tabLabel: some View {
        switch self {
        case .home:
            Label {
                Text("Home")
            } icon: {
                Image(systemName: "checklist")
            }
        case .categories:
            Label {
                Text("Categories")
            } icon: {
                Image(systemName: "folder")
            }
        case .settings:
            Label {
                Text("Settings")
            } icon: {
                Image(systemName: "gearshape")
            }
        }
    }
}
