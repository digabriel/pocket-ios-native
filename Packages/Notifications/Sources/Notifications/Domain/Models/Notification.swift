//
//  Notification.swift
//  
//
//  Created by Dimas Gabriel on 6/20/24.
//

import SwiftData

@Model
final class NotificationBucket {
    @Attribute(.unique) let key: Int
    var isEnabled: Bool

    public init(key: Key, isEnabled: Bool) {
        self.key = key.rawValue
        self.isEnabled = isEnabled
    }

    enum Key: Int, CaseIterable {
        case dailyExpenses = 0
        case billReminders = 1
    }
}
