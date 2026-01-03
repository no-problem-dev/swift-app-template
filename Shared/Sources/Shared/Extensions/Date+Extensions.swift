import Foundation

public extension Date {
    /// Returns the start of the day for this date
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    /// Returns the end of the day for this date
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? self
    }

    /// Checks if this date is today
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// Checks if this date is in the past
    var isPast: Bool {
        self < Date()
    }

    /// Checks if this date is in the future
    var isFuture: Bool {
        self > Date()
    }

    /// Returns a formatted string for display
    func formatted(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
