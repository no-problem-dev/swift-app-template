import SwiftUI
import UIRouting

public struct MainTabView: View {
    @State private var tabPresenter = TabPresenter(
        initialTab: AppTab.home
    )

    public init() {}

    public var body: some View {
        TabRouting(
            tabPresenter: tabPresenter,
            tabs: [.home, .categories, .settings]
        )
    }
}
