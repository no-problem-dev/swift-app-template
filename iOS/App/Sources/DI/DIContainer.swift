import APIClient
import Authentication
import Foundation
import SwiftUI
import UseCases

/// DIコンテナ
struct DIContainer: Dependencies {
    private let apiClient: APIClientImpl
    let useCases: UseCaseContainerImpl<APIClientImpl, AuthenticationUseCaseImpl>
    var httpEvents: AsyncStream<HTTPEvent> { apiClient.events }
    var httpLogs: AsyncStream<HTTPLog> { apiClient.logs }

    init() {
        let environment = AppEnvironment.current
        guard let baseURL = URL(string: environment.apiBaseURL) else {
            fatalError("Invalid API base URL: \(environment.apiBaseURL)")
        }
        let client = APIClientImpl(
            baseURL: baseURL,
            authTokenProvider: FirebaseAuthTokenProvider()
        )
        self.apiClient = client
        let auth = AuthenticationUseCaseImpl(
            apiClient: client,
            authenticationPath: "/v1/auth/initialize"
        )
        self.useCases = UseCaseContainerImpl(executor: client, auth: auth)
    }
}

enum AppEnvironment {
    case development
    case production

    static var current: AppEnvironment {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }

    var apiBaseURL: String {
        switch self {
        case .development:
            return ProcessInfo.processInfo.environment["API_BASE_URL"] ?? "http://localhost:8080"
        case .production:
            return ProcessInfo.processInfo.environment["API_BASE_URL"] ?? "https://api.example.com"
        }
    }
}
