import Shared
import SwiftUI

/// Badge component for displaying a category
struct CategoryBadge: View {
    let category: TodoCategory

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(Color(hex: category.color))
                .frame(width: 8, height: 8)

            Text(category.name)
                .font(.caption)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(hex: category.color).opacity(0.15))
        .clipShape(Capsule())
    }
}
