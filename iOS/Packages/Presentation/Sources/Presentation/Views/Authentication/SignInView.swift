import Authentication
import DesignSystem
import SwiftUI

/// サインイン画面
struct SignInView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var showContent = false

    var body: some View {
        GeometryReader { _ in
            ZStack {
                // グラデーション背景
                LinearGradient(
                    colors: [
                        colors.primary.opacity(0.15),
                        colors.surface.opacity(0.5),
                        colors.background
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    // ヒーローセクション
                    VStack(spacing: spacing.md) {
                        // アプリアイコン
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 64))
                            .foregroundColor(colors.primary)
                            .shadow(color: colors.primary.opacity(0.2), radius: 12)
                            .scaleEffect(showContent ? 1 : 0.8)
                            .opacity(showContent ? 1 : 0)

                        // アプリ名
                        Text("App Template")
                            .typography(.headlineLarge)
                            .foregroundColor(colors.onBackground)
                            .opacity(showContent ? 1 : 0)
                            .offset(y: showContent ? 0 : 10)

                        // タグライン
                        Text("Your productivity companion")
                            .typography(.bodyMedium)
                            .foregroundColor(colors.onBackground.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .opacity(showContent ? 1 : 0)
                            .offset(y: showContent ? 0 : 10)
                    }

                    Spacer()

                    // 認証カード
                    Card(elevation: .level4) {
                        VStack(spacing: spacing.lg) {
                            // ウェルカムテキスト
                            Text("Let's get started")
                                .typography(.titleMedium)
                                .foregroundColor(colors.onSurface)
                                .multilineTextAlignment(.center)

                            // Sign in with Apple ボタン
                            AppleSignInButton(style: .black) { error in
                                handleError(error)
                            }
                            .frame(height: 56)

                            // Google Sign in ボタン
                            GoogleSignInButton { error in
                                handleError(error)
                            }

                            // 利用規約・プライバシーポリシー
                            HStack(spacing: spacing.md) {
                                Link("Terms of Service", destination: URL(string: "https://example.com/terms")!)
                                Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
                            }
                            .typography(.labelSmall)
                            .foregroundColor(colors.primary)
                        }
                        .padding(spacing.lg)
                    }
                    .padding(.horizontal, spacing.lg)
                    .padding(.bottom, spacing.xl)
                    .scaleEffect(showContent ? 1 : 0.95)
                    .opacity(showContent ? 1 : 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            // 登場アニメーション
            withAnimation(.easeOut(duration: 0.6)) {
                showContent = true
            }
        }
    }

    private func handleError(_ error: Error) {
        print("Sign in error: \(error.localizedDescription)")
        // エラーハンドリングは AuthenticatedRootView で処理
    }
}
