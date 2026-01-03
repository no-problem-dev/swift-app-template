import Authentication
import DesignSystem
import SwiftUI
import UseCases

/// アプリのルートビュー
///
/// 認証状態に応じて適切な画面を表示します：
/// - loading: 認証確認中
/// - unauthenticated: サインイン画面
/// - error: エラー画面
/// - authenticated: メインタブ画面
public struct AppRootView: View {
    private let authenticationUseCase: AuthenticationUseCase

    /// テーマプロバイダー（AppThemeを使用、システムモードに従う）
    @State private var themeProvider = ThemeProvider(
        initialTheme: AppTheme(),
        initialMode: .system
    )

    @State private var todoStore = TodoStore()
    @State private var categoryStore = CategoryStore()

    public init(authenticationUseCase: AuthenticationUseCase) {
        self.authenticationUseCase = authenticationUseCase
    }

    public var body: some View {
        AuthenticatedRootView(
            loading: {
                LoadingView()
            },
            unauthenticated: {
                SignInView()
            },
            error: { error in
                ErrorView(error: error)
            },
            authenticated: {
                MainTabView()
                    .environment(\.todoStore, todoStore)
                    .environment(\.categoryStore, categoryStore)
            }
        )
        .theme(themeProvider)
        .authenticationUseCase(authenticationUseCase)
    }
}

// MARK: - Loading View

struct LoadingView: View {
    var body: some View {
        ProgressView()
    }
}

// MARK: - Error View

struct ErrorView: View {
    let error: Error

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.red)

            Text("An error occurred")
                .font(.headline)

            Text(error.localizedDescription)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
