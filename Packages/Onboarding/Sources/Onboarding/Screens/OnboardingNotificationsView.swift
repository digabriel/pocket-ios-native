//
//  OnboardingNotificationsView.swift
//  
//
//  Created by Dimas Gabriel on 6/20/24.
//

import SwiftUI
import Styleguide
import Notifications
import SwiftData

public struct OnboardingNotificationsView: View {
    @EnvironmentObject private var mainViewModel: OnboardingMainView.ViewModel

    public var body: some View {
        VStack(spacing: Dimensions.shared.fourteen) {
            Spacer()

            Image("bell", bundle: .module)
            titleView
                .layoutPriority(1)
            notificationsView
                .layoutPriority(1)

            Spacer()

            CapsuleButton(title: "Continue") {}
        }
        .padding()
        .background(Color.background.lightGray)
    }

    private var titleView: some View {
        VStack(spacing: Dimensions.shared.eight) {
            Text("A little nudge?")
                .foregroundStyle(Color.regular.black)
                .font(Font.title.largeRounded)

            Text("Users with notifications enabled are over 2x more likely to stick to their budgets")
                .foregroundStyle(Color.regular.gray)
                .font(Font.text.regular)
        }
        .multilineTextAlignment(.center)
    }

    private var notificationsView: some View {
        NotificationBucketTogglerList(
            modelContext: mainViewModel.modelContext,
            keys: [.billReminders, .dailyExpenses]
        )
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NotificationBucket.self, configurations: configuration)

    container.mainContext.insert(NotificationBucket(key: .billReminders, isEnabled: false))
    container.mainContext.insert(NotificationBucket(key: .dailyExpenses, isEnabled: false))

    let viewModel = OnboardingMainView.ViewModel(modelContext: container.mainContext)

    return OnboardingNotificationsView()
        .environmentObject(viewModel)
        .modelContainer(container)
}
