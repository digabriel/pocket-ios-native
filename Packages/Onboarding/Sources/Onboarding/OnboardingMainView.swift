//
//  OnboardingMainView.swift
//  
//
//  Created by Dimas Gabriel on 6/24/24.
//

import SwiftUI
import Notifications
import SwiftData

public struct OnboardingMainView: View {
    @EnvironmentObject var viewModel: ViewModel

    public init() {}

    public var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            EmptyView()
                .navigationDestination(for: OnboardingNavigationPath.self) { path in
                    switch path {
                    case .landing:
                        OnboardingLandingView()
                            .navigationBarBackButtonHidden()
                    case .notifications:
                        OnboardingNotificationsView(modelContext: viewModel.modelContext)
                            .navigationBarBackButtonHidden()
                    }
                }
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NotificationBucket.self, configurations: configuration)

    container.mainContext.insert(NotificationBucket(key: .billReminders, isEnabled: false))
    container.mainContext.insert(NotificationBucket(key: .dailyExpenses, isEnabled: false))

    let viewModel = OnboardingMainView.ViewModel(modelContext: container.mainContext)

    return OnboardingMainView()
        .environmentObject(viewModel)
        .modelContainer(container)
}
