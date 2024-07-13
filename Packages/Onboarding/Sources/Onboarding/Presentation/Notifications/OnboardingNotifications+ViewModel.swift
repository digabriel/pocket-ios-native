//
//  OnboardingNotifications+ViewModel.swift
//  
//
//  Created by Dimas Gabriel on 6/29/24.
//

import SwiftData
import SwiftUI
import Notifications

extension OnboardingNotificationsView {
    @MainActor @Observable final class ViewModel {
        private let dependency: Dependency

        // Outputs
        let modelContext: ModelContext
        private(set) var notificationRegistrationStatus: NotificationRegistrationStatus = .notDetermined
        private(set) var notificationRegistrationError: Error?

        init(modelContext: ModelContext, dependency: Dependency = .init()) {
            self.modelContext = modelContext
            self.dependency = dependency
        }

        func registerForNotifications() async {
            do {
                notificationRegistrationStatus = try await dependency.registerForNotifications.execute(input: ())
            } catch {
                notificationRegistrationError = error
            }
        }
    }
}

extension OnboardingNotificationsView.ViewModel {
    struct Dependency {
        let registerForNotifications: any RegisterForNotificationsUseCaseProtocol

        init(registerForNotifications: any RegisterForNotificationsUseCaseProtocol = NotificationsUseCaseFactory.makeRegistrationUseCase()) {
            self .registerForNotifications = registerForNotifications
        }
    }

}
