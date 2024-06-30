//
//  OnboardingUseCaseFactory.swift
//  
//
//  Created by Dimas Gabriel on 6/29/24.
//

public struct OnboardingUseCaseFactory {
    public static func makeIsOnboardingDone() -> any IsOnboardingDoneUseCase {
        return IsOnboardingDoneUseCaseImpl()
    }

    public static func makeSetOnboardingDone() -> any SetOnboardingDoneUseCase {
        return SetOnboardingDoneUseCaseImpl()
    }
}
