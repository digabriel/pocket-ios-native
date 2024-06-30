//
//  OnboardingMainView+ViewModel.swift
//  
//
//  Created by Dimas Gabriel on 6/26/24.
//

import Combine
import SwiftData

public extension OnboardingMainView {
    final class ViewModel: ObservableObject {
        @Published var navigationPath: [OnboardingNavigationPath] = [.landing]
        let modelContext: ModelContext
        let dependency: Dependency

        public init(modelContext: ModelContext, dependency: Dependency) {
            self.modelContext = modelContext
            self.dependency = dependency
        }

        func navigateNext() {
            guard let nextPath = navigationPath.last?.next else {
                return setOnboardingDone()
            }
            navigationPath.append(nextPath)
        }

        private func setOnboardingDone() {
            Task {
                try? await dependency.setOnboardingDoneUseCase.execute(input: ())
            }
        }
    }
}

public extension OnboardingMainView.ViewModel {
    struct Dependency {
        let setOnboardingDoneUseCase: any SetOnboardingDoneUseCase

        public init(setOnboardingDoneUseCase: any SetOnboardingDoneUseCase) {
            self.setOnboardingDoneUseCase = setOnboardingDoneUseCase
        }
    }
}

enum OnboardingNavigationPath {
    case landing
    case notifications

    var next: OnboardingNavigationPath? {
        switch self {
        case .landing:
            return .notifications
        case .notifications:
            return nil
        }
    }
}
