//
//  RegisterForNotifications.swift
//  
//
//  Created by Dimas Gabriel on 6/26/24.
//

import CommonDomain
import UserNotifications

public protocol RegisterForNotificationsUseCaseProtocol: UseCase where Input == Void, Output == NotificationRegistrationStatus {}

public struct RegisterForNotificationsUseCase: RegisterForNotificationsUseCaseProtocol {
    let repository: NotificationsRegistrationStatusFetching & NotificationsRegistrationStatusCreating

    public func execute(input: Void) async -> NotificationRegistrationStatus {
        var currentStatus = await repository.currentStatus()

        if currentStatus == .notDetermined {
            currentStatus = await askForRegistration()
        }

        return currentStatus
    }
}

private extension RegisterForNotificationsUseCase {
    func askForRegistration() async -> NotificationRegistrationStatus {
        do {
            let result = try await repository.registerForNotifications()
            return result ? .granted : .denied
        } catch {
            return .notDetermined
        }
    }
}
