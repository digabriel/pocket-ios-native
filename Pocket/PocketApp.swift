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

@main
struct PocketApp: App {
    let container: ModelContainer
    @State private var isLoading = true
    @State private var isOnboardingDone = false

    init() {
        do {
            container = try ModelContainer(for: NotificationBucket.self)

            Task {
                await NotificationPackage()?.setupData()
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
                    Text("Onboarding Done")
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
