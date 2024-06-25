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

        public init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }

        func navigateNext() {
            guard let nextPath = navigationPath.last?.next else { return }
            navigationPath.append(nextPath)
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
