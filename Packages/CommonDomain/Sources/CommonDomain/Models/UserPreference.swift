//
//  UserPreference.swift
//
//
//  Created by Dimas Gabriel on 6/29/24.
//

public struct UserPreference {
    public enum Key: String {
        case hasDoneOnboarding
    }

    public let key: Key
    public let value: Bool

    public init(key: Key, value: Bool) {
        self.key = key
        self.value = value
    }
}
