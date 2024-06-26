//
//  NotificationsRegistrationRepository.swift
//  
//
//  Created by Dimas Gabriel on 6/26/24.
//

import UserNotifications

protocol NotificationsRegistrationStatusFetching {
    func currentStatus() async -> NotificationRegistrationStatus
}

protocol NotificationsRegistrationStatusCreating {
    func registerForNotifications() async throws -> Bool
}

extension UNUserNotificationCenter: NotificationsRegistrationStatusCreating, NotificationsRegistrationStatusFetching {
    func registerForNotifications() async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            requestAuthorization(options: [.badge, .alert, .sound]) { result, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: result)
                }
            }
        }
    }

    func currentStatus() async -> NotificationRegistrationStatus {
        await withCheckedContinuation { continuation in
            getNotificationSettings { settings in
                let status = NotificationRegistrationStatusMapper.from(status: settings.authorizationStatus)
                continuation.resume(returning: status)
            }
        }
    }
}
