//
//  SetOnboardingDone.swift
//  
//
//  Created by Dimas Gabriel on 6/29/24.
//

import CommonDomain

public protocol SetOnboardingDoneUseCase: UseCase where Input == Void, Output == Void {}

final class SetOnboardingDoneUseCaseImpl: SetOnboardingDoneUseCase {
    private let userPreferenceRepository: UserPreferenceRepository

    init(userPreferenceRepository: UserPreferenceRepository = UserPreferenceRepositoryImpl()) {
        self.userPreferenceRepository = userPreferenceRepository
    }

    func execute(input: Void) async throws {
        let preference = UserPreference(key: .hasDoneOnboarding, value: true)
        userPreferenceRepository.set(preference: preference)
    }
}
