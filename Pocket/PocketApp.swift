//
//  PocketApp.swift
//  Pocket
//
//  Created by Dimas Gabriel on 6/19/24.
//

import SwiftUI
import Onboarding
import Notifications
import SwiftData
import Wallets

@main
struct PocketApp: App {
    let container: ModelContainer
    @State private var isLoading = true
    @State private var isOnboardingDone = false

    init() {
        do {
            let container = try ModelContainer(for: NotificationBucket.self, WalletCategory.self)
            self.container = container

            Task {
                await NotificationPackage(modelContainer: container).setupData()
                await WalletsPackage(modelContainer: container).setupData()
            }
        } catch {
            fatalError("Failed to create ModelContainer.")
        }
    }

    var body: some Scene {
        WindowGroup {
            if isLoading {
                Text("Loading")
                    .task { await loadOnboardingStatus() }
            } else {
                if isOnboardingDone {
                    MainTabView()
                } else {
                    onboardingView
                }
            }
        }
        .modelContainer(container)
    }

    private func loadOnboardingStatus() async {
        isOnboardingDone = (try? await OnboardingUseCaseFactory.makeIsOnboardingDone().execute(input: ())) ?? false
        isLoading = false
    }

    private var onboardingView: some View {
        OnboardingMainView()
            .environmentObject(OnboardingMainView.ViewModel(
                modelContext: container.mainContext,
                dependency: .init(setOnboardingDoneUseCase: OnboardingUseCaseFactory.makeSetOnboardingDone())
            ))
    }
}
