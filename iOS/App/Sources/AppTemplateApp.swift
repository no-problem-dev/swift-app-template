import Authentication
import Presentation
import SwiftUI
import UseCases

@main
struct AppTemplateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let container: DIContainer

    init() {
        Self.configureFirebase()
        self.container = DIContainer()
    }

    var body: some Scene {
        WindowGroup {
            RootContentView()
                .environment(\.dependencies, container)
        }
    }

    private static func configureFirebase() {
        #if DEBUG
        let environment: FirebaseConfigure.Environment = {
            if ProcessInfo.processInfo.environment["USE_PRODUCTION"] == "true" {
                return .production
            }
            return .defaultEmulator
        }()
        FirebaseConfigure.configure(environment: environment, enableDebugMode: true)
        #else
        FirebaseConfigure.configure(environment: .production)
        #endif
    }
}
