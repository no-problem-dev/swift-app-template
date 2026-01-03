import SwiftUI
import UIRouting

enum AppAlert: @MainActor Alertable {
    case deleteConfirmation(onConfirm: () -> Void)
    case error(message: String)

    var title: String {
        switch self {
        case .deleteConfirmation:
            return "Confirm Delete"
        case .error:
            return "Error"
        }
    }

    var message: String? {
        switch self {
        case .deleteConfirmation:
            return "Are you sure you want to delete this item?"
        case .error(let message):
            return message
        }
    }

    var actions: [AlertAction] {
        switch self {
        case .deleteConfirmation(let onConfirm):
            return [
                AlertAction(title: "Cancel", role: .cancel, action: {}),
                AlertAction(title: "Delete", role: .destructive, action: onConfirm)
            ]
        case .error:
            return [AlertAction(title: "OK", role: nil, action: {})]
        }
    }
}
