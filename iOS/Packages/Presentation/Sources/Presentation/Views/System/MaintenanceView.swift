import DesignSystem
import SwiftUI

/// メンテナンス画面
///
/// サーバーが503（Service Unavailable）を返した際に表示されるメンテナンス画面。
/// ユーザーに状況を伝え、再試行ボタンを提供します。
public struct MaintenanceView: View {
    /// 再試行アクション
    let onRetry: () -> Void

    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    @State private var isRotating = false

    public init(onRetry: @escaping () -> Void) {
        self.onRetry = onRetry
    }

    public var body: some View {
        VStack(spacing: spacing.xl) {
            Spacer()

            // メンテナンスアイコン
            Image(systemName: "wrench.and.screwdriver")
                .font(.system(size: 72))
                .foregroundStyle(
                    LinearGradient(
                        colors: [colors.primary, colors.primary.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .rotationEffect(.degrees(isRotating ? 10 : -10))
                .animation(
                    .easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                    value: isRotating
                )

            VStack(spacing: spacing.md) {
                Text("Under Maintenance")
                    .typography(.headlineLarge)
                    .foregroundColor(colors.onBackground)

                Text("The server is currently under maintenance.\nPlease wait a moment and try again.")
                    .typography(.bodyMedium)
                    .foregroundColor(colors.onBackground.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }

            Spacer()

            // 再試行ボタン
            Button(action: onRetry) {
                HStack(spacing: spacing.sm) {
                    Image(systemName: "arrow.clockwise")
                    Text("Retry")
                }
                .typography(.labelLarge)
                .foregroundColor(colors.onPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, spacing.md)
                .background(colors.primary)
                .cornerRadius(12)
            }
            .padding(.horizontal, spacing.xl)
            .padding(.bottom, spacing.xl)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [
                    colors.primary.opacity(0.05),
                    colors.background
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .onAppear {
            isRotating = true
        }
    }
}
