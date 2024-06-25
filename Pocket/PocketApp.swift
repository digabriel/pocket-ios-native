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
            OnboardingMainView()
                .environmentObject(OnboardingMainView.ViewModel(modelContext: container.mainContext))
        }
        .modelContainer(container)
    }
}
