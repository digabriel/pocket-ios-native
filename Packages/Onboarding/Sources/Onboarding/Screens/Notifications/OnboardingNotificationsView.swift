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
    @State private var viewModel: ViewModel
    @EnvironmentObject private var mainViewModel: OnboardingMainView.ViewModel

    init(modelContext: ModelContext) {
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: Dimensions.shared.fourteen) {
            Spacer()

            Image("bell", bundle: .module)
            titleView
                .layoutPriority(1)
            notificationsView
                .layoutPriority(1)

            Spacer()

            CapsuleButton(title: "Continue") {
                Task {
                    await viewModel.registerForNotifications()
                }
            }
        }
        .padding()
        .background(Color.background.lightGray)
        .onChange(of: viewModel.notificationRegistrationStatus) { _, newValue in
            switch newValue {
            case .granted:
                mainViewModel.navigateNext()
            case .denied:
                break
            // TODO: Show alert for the denied case
            case .notDetermined:
                break
            }
        }
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
            modelContext: viewModel.modelContext,
            keys: [.billReminders, .dailyExpenses]
        )
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NotificationBucket.self, configurations: configuration)

    container.mainContext.insert(NotificationBucket(key: .billReminders, isEnabled: false))
    container.mainContext.insert(NotificationBucket(key: .dailyExpenses, isEnabled: false))

    let mainViewModel = OnboardingMainView.ViewModel(modelContext: container.mainContext)

    return OnboardingNotificationsView(modelContext: container.mainContext)
        .modelContainer(container)
        .environmentObject(mainViewModel)
}
