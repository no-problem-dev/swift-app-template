import APIClient
import DesignSystem
import SwiftUI
import UseCases

/// アプリのルートビュー（HTTPイベント購読・サービス状態管理）
public struct RootContentView: View {
    @Environment(\.dependencies) private var dependencies
    @State private var serviceStatusStore = ServiceStatusStore()

    public init() {}

    public var body: some View {
        Group {
            if serviceStatusStore.status == .maintenance {
                MaintenanceView {
                    serviceStatusStore.reset()
                }
            } else {
                AppRootView(authenticationUseCase: dependencies.useCases.auth)
            }
        }
        .environment(\.serviceStatusStore, serviceStatusStore)
        .task { await subscribeToHTTPEvents() }
        .task { await subscribeToHTTPLogs() }
    }

    private func subscribeToHTTPEvents() async {
        for await event in dependencies.httpEvents {
            await handleHTTPEvent(event)
        }
    }

    private func subscribeToHTTPLogs() async {
        #if DEBUG
        for await log in dependencies.httpLogs {
            print(log)
        }
        #endif
    }

    @MainActor
    private func handleHTTPEvent(_ event: HTTPEvent) async {
        switch event {
        case .unauthorized(let endpoint, _):
            print("[HTTPEvent] 🔐 Unauthorized: \(endpoint.path)")
            serviceStatusStore.setUnauthorized()
            try? await dependencies.useCases.auth.signOut()

        case .serviceUnavailable(let endpoint, _):
            print("[HTTPEvent] 🔧 Service Unavailable: \(endpoint.path)")
            serviceStatusStore.setMaintenance()

        case .forbidden(let endpoint, _):
            print("[HTTPEvent] 🚫 Forbidden: \(endpoint.path)")

        case .rateLimited(let endpoint, let retryAfter, _):
            if let retryAfter {
                print("[HTTPEvent] ⏱️ Rate Limited: \(endpoint.path), retry after \(retryAfter)s")
            } else {
                print("[HTTPEvent] ⏱️ Rate Limited: \(endpoint.path)")
            }

        case .serverError(let statusCode, let endpoint, _):
            print("[HTTPEvent] ❌ Server Error (\(statusCode)): \(endpoint.path)")
        }
    }
}
