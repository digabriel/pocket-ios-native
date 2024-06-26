//
//  UN.swift
//  
//
//  Created by Dimas Gabriel on 6/26/24.
//
import UserNotifications

struct NotificationRegistrationStatusMapper {
    static func from(status: UNAuthorizationStatus) -> NotificationRegistrationStatus {
        switch status {
        case .notDetermined, .provisional:
            return .notDetermined
        case .denied:
            return .denied
        case .authorized, .ephemeral:
            return .granted
        @unknown default:
            return .notDetermined
        }
    }
}
