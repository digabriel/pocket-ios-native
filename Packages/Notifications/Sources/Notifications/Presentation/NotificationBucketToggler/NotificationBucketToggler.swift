//
//  NotificationBucketToggler.swift
//  
//
//  Created by Dimas Gabriel on 6/20/24.
//

import SwiftUI
import SwiftData
import Styleguide

public struct NotificationBucketTogglerList: View {
    @State private var viewModel: ViewModel

    public init(modelContext: ModelContext, keys: [NotificationBucket.Key]) {
        let viewModel = ViewModel(modelContext: modelContext, keys: keys)
        _viewModel = State(initialValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: Dimensions.shared.fourteen) {
            ForEach(viewModel.notificationBuckets) { bucket in
                toggle(for: bucket)
            }
        }
        .padding(.all, Dimensions.shared.fourteen)
        .background(Color.regular.white)
        .cornerRadius(16)
        .shadow(color: Color.regular.black.opacity(0.25), radius: 10, y: 4)
    }

    @ViewBuilder func toggle(for bucket: NotificationBucket) -> some View {
        let isEnabled = $viewModel
            .notificationBuckets
            .first { $0.wrappedValue.key == bucket.key }?.isEnabled ?? .constant(false)

        Toggle(
            title: bucket.title,
            description: bucket.message,
            isEnabled: isEnabled
        )
        .tint(Color.regular.yellow)
    }
}

private extension NotificationBucket {
    var title: String {
        guard let key = Key(rawValue: self.key) else { return "" }

        switch key {
        case .billReminders:
            return String(localized: "Bill reminders")
        case .dailyExpenses:
            return String(localized: "Daily expenses")
        }
    }

    var message: String {
        guard let key = Key(rawValue: self.key) else { return "" }

        switch key {
        case .billReminders:
            return String(localized: "We'll nudge you when it's time to pay the bills")
        case .dailyExpenses:
            return String(localized: "Get a reminder to add your expenses")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NotificationBucket.self, configurations: config)

    container.mainContext.insert(NotificationBucket(key: .billReminders, isEnabled: false))
    container.mainContext.insert(NotificationBucket(key: .dailyExpenses, isEnabled: true))

    return NotificationBucketTogglerList(
        modelContext: container.mainContext,
        keys: [.billReminders, .dailyExpenses]
    )
    .modelContainer(container)
    .padding()
    .background(Color.background.lightGray)
}
