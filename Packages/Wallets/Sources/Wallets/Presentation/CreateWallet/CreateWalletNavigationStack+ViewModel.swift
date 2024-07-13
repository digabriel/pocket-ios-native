//
//  CreateWalletNavigationStack+ViewModel.swift
//  
//
//  Created by Dimas Gabriel on 7/8/24.
//

import Foundation

extension CreateWalletNavigationStack {
    @MainActor @Observable final class ViewModel {
        private let dependency: Dependency

        private(set) var sections: [Section] = []
        var currentSectionIndex = 0 {
            didSet {
                activeSection = sections[currentSectionIndex]
            }
        }
        var activeSection: Section?

        init(dependency: Dependency) {
            self.dependency = dependency
        }

        func refresh() async {
            do {
                let walletCategories = try await dependency.getWalletCategoriesUseCase.execute(input: ())
                sections = walletCategories.map { .init(title: $0.name, tipText: $0.tipText) }
            } catch {
                sections = []
            }
        }
    }
}

extension CreateWalletNavigationStack {
    struct Section {
        let title: String
        let tipText: String?
    }

    struct Dependency: Sendable {
        let getWalletCategoriesUseCase: any GetWalletCategoriesProtocol
    }
}

private extension WalletCategory {
    var tipText: String? {
        switch self {
        case .spending:
            return nil
        case .savings:
return String(localized: """
People who set their savings goal save faster and up to $550 more a year than people who don’t.
""")
        case .debt:
return String(localized: """
Debt wallets reduces your net worth. Expenses added from debt wallet deminishes the remaining balance of the wallet.
""")
        }
    }
}
