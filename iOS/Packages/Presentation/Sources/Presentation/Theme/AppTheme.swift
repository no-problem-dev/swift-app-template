import SwiftUI
import DesignSystem

public struct AppTheme: Theme {
    public init() {}

    public let id = "app-template"
    public let name = "App Template"
    public let description = "Default app template theme"
    public let category: ThemeCategory = .custom

    public var previewColors: [Color] {
        [
            Color(hex: "#007AFF"),
            Color(hex: "#5856D6"),
            Color(hex: "#34C759"),
            Color(hex: "#F2F2F7")
        ]
    }

    public func colorPalette(for mode: ThemeMode) -> any ColorPalette {
        switch mode {
        case .system, .light:
            return AppLightPalette()
        case .dark:
            return AppDarkPalette()
        }
    }
}

public struct AppLightPalette: ColorPalette {
    public init() {}

    public var primary: Color { Color(hex: "#007AFF") }
    public var onPrimary: Color { Color(hex: "#FFFFFF") }
    public var primaryContainer: Color { Color(hex: "#D1E4F7") }
    public var onPrimaryContainer: Color { Color(hex: "#001D35") }

    public var secondary: Color { Color(hex: "#5856D6") }
    public var onSecondary: Color { Color(hex: "#FFFFFF") }
    public var secondaryContainer: Color { Color(hex: "#E8E7F6") }
    public var onSecondaryContainer: Color { Color(hex: "#1D1B4B") }

    public var tertiary: Color { Color(hex: "#34C759") }
    public var onTertiary: Color { Color(hex: "#FFFFFF") }

    public var background: Color { Color(hex: "#F2F2F7") }
    public var onBackground: Color { Color(hex: "#000000") }
    public var surface: Color { Color(hex: "#FFFFFF") }
    public var onSurface: Color { Color(hex: "#000000") }
    public var surfaceVariant: Color { Color(hex: "#E5E5EA") }
    public var onSurfaceVariant: Color { Color(hex: "#3C3C43") }

    public var error: Color { Color(hex: "#FF3B30") }
    public var onError: Color { Color(hex: "#FFFFFF") }
    public var errorContainer: Color { Color(hex: "#FFDAD6") }
    public var onErrorContainer: Color { Color(hex: "#410002") }

    public var warning: Color { Color(hex: "#FF9500") }
    public var onWarning: Color { Color(hex: "#FFFFFF") }
    public var success: Color { Color(hex: "#34C759") }
    public var onSuccess: Color { Color(hex: "#FFFFFF") }
    public var info: Color { Color(hex: "#007AFF") }
    public var onInfo: Color { Color(hex: "#FFFFFF") }

    public var outline: Color { Color(hex: "#C7C7CC") }
    public var outlineVariant: Color { Color(hex: "#E5E5EA") }
}

public struct AppDarkPalette: ColorPalette {
    public init() {}

    public var primary: Color { Color(hex: "#0A84FF") }
    public var onPrimary: Color { Color(hex: "#FFFFFF") }
    public var primaryContainer: Color { Color(hex: "#003A6E") }
    public var onPrimaryContainer: Color { Color(hex: "#D1E4F7") }

    public var secondary: Color { Color(hex: "#5E5CE6") }
    public var onSecondary: Color { Color(hex: "#FFFFFF") }
    public var secondaryContainer: Color { Color(hex: "#3A387A") }
    public var onSecondaryContainer: Color { Color(hex: "#E8E7F6") }

    public var tertiary: Color { Color(hex: "#32D74B") }
    public var onTertiary: Color { Color(hex: "#003A00") }

    public var background: Color { Color(hex: "#000000") }
    public var onBackground: Color { Color(hex: "#FFFFFF") }
    public var surface: Color { Color(hex: "#1C1C1E") }
    public var onSurface: Color { Color(hex: "#FFFFFF") }
    public var surfaceVariant: Color { Color(hex: "#2C2C2E") }
    public var onSurfaceVariant: Color { Color(hex: "#EBEBF5") }

    public var error: Color { Color(hex: "#FF453A") }
    public var onError: Color { Color(hex: "#FFFFFF") }
    public var errorContainer: Color { Color(hex: "#8C1D18") }
    public var onErrorContainer: Color { Color(hex: "#FFDAD6") }

    public var warning: Color { Color(hex: "#FF9F0A") }
    public var onWarning: Color { Color(hex: "#000000") }
    public var success: Color { Color(hex: "#32D74B") }
    public var onSuccess: Color { Color(hex: "#000000") }
    public var info: Color { Color(hex: "#0A84FF") }
    public var onInfo: Color { Color(hex: "#FFFFFF") }

    public var outline: Color { Color(hex: "#38383A") }
    public var outlineVariant: Color { Color(hex: "#2C2C2E") }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
