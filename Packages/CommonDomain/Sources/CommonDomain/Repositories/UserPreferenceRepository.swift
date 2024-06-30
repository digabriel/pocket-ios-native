//
//  UserPreferenceRepository.swift
//
//
//  Created by Dimas Gabriel on 6/29/24.
//

import Foundation

public protocol UserPreferenceRepository {
    func set(preference: UserPreference)
    func preference(for key: UserPreference.Key) -> UserPreference
}

public final class UserPreferenceRepositoryImpl: UserPreferenceRepository {
    let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func set(preference: UserPreference) {
        userDefaults.setValue(preference.value, forKey: preference.key.rawValue)
    }

    public func preference(for key: UserPreference.Key) -> UserPreference {
        let value = userDefaults.bool(forKey: key.rawValue)
        return .init(key: key, value: value)
    }
}
