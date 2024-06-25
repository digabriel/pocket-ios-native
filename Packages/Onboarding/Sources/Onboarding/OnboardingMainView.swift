//
//  OnboardingMainView.swift
//  
//
//  Created by Dimas Gabriel on 6/24/24.
//

import SwiftUI
import Notifications
import SwiftData

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

public struct OnboardingMainView: View {
    @EnvironmentObject var viewModel: ViewModel

    public init() {}

    public var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            EmptyView()
                .navigationDestination(for: OnboardingNavigationPath.self) { path in
                    switch path {
                    case .landing:
                        OnboardingLandingView()
                            .navigationBarBackButtonHidden()
                    case .notifications:
                        OnboardingNotificationsView()
                            .navigationBarBackButtonHidden()
                    }
                }
        }
    }
}

public extension OnboardingMainView {
    final class ViewModel: ObservableObject {
        @Published var navigationPath: [OnboardingNavigationPath] = [.landing]
        let modelContext: ModelContext

        public init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }

        func navigateNext() {
            guard let nextPath = navigationPath.first?.next else { return }
            navigationPath.append(nextPath)
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NotificationBucket.self, configurations: configuration)

    container.mainContext.insert(NotificationBucket(key: .billReminders, isEnabled: false))
    container.mainContext.insert(NotificationBucket(key: .dailyExpenses, isEnabled: false))

    let viewModel = OnboardingMainView.ViewModel(modelContext: container.mainContext)

    return OnboardingMainView()
        .environmentObject(viewModel)
        .modelContainer(container)
}
