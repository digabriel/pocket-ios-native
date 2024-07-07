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
    private let swiftDataContainer: ModelContainer
    private let walletsPackage: SwiftUIWalletsPackage
    private let notificationsPackage: NotificationPackage

    @State private var isLoading = true
    @State private var isOnboardingDone = false

    init() {
        do {
            let container = try ModelContainer(for: NotificationBucket.self, SwiftDataWallet.self)
            self.swiftDataContainer = container
            let walletsPackage = SwiftUIWalletsPackage(swiftDataContainer: container)
            self.walletsPackage = walletsPackage
            self.notificationsPackage = NotificationPackage(modelContainer: container)
        } catch {
            fatalError("Failed to create ModelContainer.")
        }
    }

    var body: some Scene {
        WindowGroup {
            if isLoading {
                Text("Loading")
                    .task { await setup() }
            } else {
                if isOnboardingDone {
                    MainTabView()
                } else {
                    onboardingView
                }
            }
        }
        .modelContainer(swiftDataContainer)
        .environment(walletsPackage)
    }

    private func setup() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await loadOnboardingStatus() }
            group.addTask { await notificationsPackage.setupData() }
            group.addTask { await walletsPackage.setupData() }
        }

        isLoading = false
    }

    private func loadOnboardingStatus() async {
        isOnboardingDone = (try? await OnboardingUseCaseFactory.makeIsOnboardingDone().execute(input: ())) ?? false
    }

    private var onboardingView: some View {
        OnboardingMainView()
            .environmentObject(OnboardingMainView.ViewModel(
                modelContext: swiftDataContainer.mainContext,
                dependency: .init(setOnboardingDoneUseCase: OnboardingUseCaseFactory.makeSetOnboardingDone())
            ))
    }
}
