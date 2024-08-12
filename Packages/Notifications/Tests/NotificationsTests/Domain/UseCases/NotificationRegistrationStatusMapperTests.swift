//
//  NotificationRegistrationStatusMapperTests.swift
//  
//
//  Created by Dimas Gabriel on 6/26/24.
//

import Testing
import UserNotifications
@testable import Notifications

struct NotificationRegistrationStatusMapperTests {
    @Test(arguments: [
        UNAuthorizationStatus.notDetermined,
        UNAuthorizationStatus.provisional,
        UNAuthorizationStatus.denied,
        UNAuthorizationStatus.authorized,
        UNAuthorizationStatus.ephemeral
    ])
    func mapFromUNAuthorizationStatus(status: UNAuthorizationStatus) {
        let result = NotificationRegistrationStatusMapper.from(status: status)

        switch status {
        case .notDetermined, .provisional:
            #expect(result == .notDetermined)
        case .denied:
            #expect(result == .denied)
        case .authorized, .ephemeral:
            #expect(result == .granted)
        @unknown default:
            #expect(result == .notDetermined)
        }
    }
}
