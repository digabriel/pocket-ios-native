//
//  Notification.swift
//  
//
//  Created by Dimas Gabriel on 6/20/24.
//

import SwiftData

@Model
public final class NotificationBucket {
    public private(set) var key: Int
    public var isEnabled: Bool

    public init(key: Key, isEnabled: Bool) {
        self.key = key.rawValue
        self.isEnabled = isEnabled
    }

    public enum Key: Int, CaseIterable {
        case dailyExpenses = 0
        case billReminders = 1
    }
}
