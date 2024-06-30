//
//  IsOnboardingDone.swift
//  
//
//  Created by Dimas Gabriel on 6/29/24.
//

import CommonDomain

public protocol IsOnboardingDoneUseCase: UseCase where Input == Void, Output == Bool {}

final class IsOnboardingDoneUseCaseImpl: IsOnboardingDoneUseCase {
    private let userPreferenceRepository: UserPreferenceRepository

    init(userPreferenceRepository: UserPreferenceRepository = UserPreferenceRepositoryImpl()) {
        self.userPreferenceRepository = userPreferenceRepository
    }

    func execute(input: Void) async throws -> Bool {
        let preference = userPreferenceRepository.preference(for: .hasDoneOnboarding)
        return preference.value
    }
}
