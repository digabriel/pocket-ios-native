//
//  NotificationsUseCaseFactory.swift
//  
//
//  Created by Dimas Gabriel on 6/26/24.
//

import UserNotifications

public struct NotificationsUseCaseFactory {
    public static func makeRegistrationUseCase() -> RegisterForNotifications {
        .init(repository: UNUserNotificationCenter.current())
    }
}
